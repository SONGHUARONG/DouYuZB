//
//  RecommendViewController.swift
//  DouYuZB
//
//  Created by huarong on 2018/3/23.
//  Copyright © 2018年 huarong. All rights reserved.
//

import UIKit

//MARK:定义一些常量
private let kItemMargin: CGFloat = 10
private let kItemW: CGFloat = (kScreenW - 3 * kItemMargin) / 2
private let kNormalItemH: CGFloat = kItemW * 3 / 4
private let kPrettyItemH: CGFloat = kItemW * 4 / 3
private let kHeaderViewH: CGFloat = 50
private let kCycleViewH: CGFloat = kScreenW * 3 / 8
private let kGameViewH: CGFloat = 90

private let kNormalCellID: String = "kNormalCellID"
private let kPrettyCellID: String = "kPrettyCellID"
private let kHeaderViewID: String = "kHeaderViewID"


//定义RecommendViewController类
class RecommendViewController: UIViewController {
    
    private lazy var recommendVM: RecommendViewModel = RecommendViewModel()
    
    private lazy var cycleView: RecommendCycleView = {
        let cycleView = RecommendCycleView.recommendCycleView()
        cycleView.frame = CGRect(x: 0, y: -(kCycleViewH + kGameViewH), width: kScreenW, height: kCycleViewH)
        return cycleView
    }()
    
    private lazy var gameView: RecommendGameView = {
        let gameView = RecommendGameView.recommendGameView()
        gameView.frame = CGRect(x: 0, y: -kGameViewH, width: kScreenW, height: kGameViewH)
        return gameView
    }()
    
    //懒加载UICollectionView
    private lazy var collectionView: UICollectionView = { [unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kNormalItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        //设置sectionHeader大小
        layout.headerReferenceSize = CGSize(width: kScreenH, height: kHeaderViewH)
        //设置每组的内边距
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.white
        //由于ViewControlelr的view不是整个屏幕大小，所以要自动拉伸
        collectionView.autoresizingMask = [.flexibleWidth,.flexibleHeight]

        //注册，以便复用
//        collectionView.register(NSClassFromString("UICollectionViewCell"), forCellWithReuseIdentifier: kNormalCellID)
        
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        
        collectionView.register(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
        collectionView.register(UINib(nibName: "CollectionPrettyCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCellID)
        
        return collectionView
    }()
    
    //系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        //设置ui界面内容
        setupUI()
        //请求数据
        loadData()
    }
}

//MARK:请求数据
extension RecommendViewController{
    private func loadData(){
//        NetworkTools.requestData(.get, URLString: "https://httpbin.org/get", parameters: ["name":"What"]) { (result) in
//            print(result)
//        }
        //1.请求推荐数据
        recommendVM.requestData(finishCallBack: {
            //1.展示推荐数据
            self.collectionView.reloadData()
            //2.将数据传递给gameView
            self.gameView.groups = self.recommendVM.anchorGroups
        })
        //2.请求无限轮播数据
        recommendVM.requestCycleData {
            self.cycleView.cycleModels = self.recommendVM.cycleModels
        }
    }
}

//MARK:设置ui界面内容
extension RecommendViewController{
    private func setupUI(){
        //1.添加collectionView
        view.addSubview(collectionView)
        //2.将cycleview添加到collectionview
        collectionView.addSubview(cycleView)
        //3.将gameView添加到collectionView中
        collectionView.addSubview(gameView)
        //4.设置collectionView的内边距
        collectionView.contentInset = UIEdgeInsets(top: kGameViewH + kCycleViewH , left: 0, bottom: 0, right: 0)
    }
}

//MARK:遵守UICollectionViewDataSource协议
extension RecommendViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return recommendVM.anchorGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let group = recommendVM.anchorGroups[section]
        return group.anchors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //1.取出模型
        let group = recommendVM.anchorGroups[indexPath.section]
        let anchor = group.anchors[indexPath.item]
        //2.定义cell
        var cell: CollectionBaseCell!
        //3.取出cell
        if indexPath.section == 1 {
           cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath) as! CollectionBaseCell
        }else{
           cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! CollectionBaseCell
        }
        //4.将模型传给cell
        cell.anchor = anchor
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath) as! CollectionHeaderView
        
        headView.group = recommendVM.anchorGroups[indexPath.section]
        return headView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: kItemW, height: kPrettyItemH)
        }
        return CGSize(width: kItemW, height: kNormalItemH)
    }
}

