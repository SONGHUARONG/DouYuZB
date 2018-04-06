//
//  BaseAnchorViewController.swift
//  DouYuZB
//
//  Created by huarong on 2018/4/6.
//  Copyright © 2018年 huarong. All rights reserved.
//

import UIKit

//MARK:定义一些常量
private let kNormalItemMargin: CGFloat = 10
let kNormalItemW: CGFloat = (kScreenW - 3 * kNormalItemMargin) / 2
let kNormalItemH: CGFloat = kNormalItemW * 3 / 4
let kPrettyItemH: CGFloat = kNormalItemW * 4 / 3
private let kHeaderViewH: CGFloat = 50

let kNormalCellID: String = "kNormalCellID"
let kPrettyCellID: String = "kPrettyCellID"
private let kHeaderViewID: String = "kHeaderViewID"

class BaseAnchorViewController: UIViewController {
    
    //MARK:定义属性
    var baseVM: BaseViewModel!
    
    //懒加载UICollectionView
    lazy var collectionView: UICollectionView = { [unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kNormalItemW, height: kNormalItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kNormalItemMargin
        //设置sectionHeader大小
        layout.headerReferenceSize = CGSize(width: kScreenH, height: kHeaderViewH)
        //设置每组的内边距
        layout.sectionInset = UIEdgeInsets(top: 0, left: kNormalItemMargin, bottom: 0, right: kNormalItemMargin)
        
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

    override func viewDidLoad() {
        super.viewDidLoad()
        //设置ui界面
        setupUI()
        //请求娱乐数据
        loadData()
    }
}

//MARK:设置ui界面内容
extension BaseAnchorViewController {
    @objc func setupUI(){
        view.addSubview(collectionView)
    }
}

//MARK:请求娱乐数据
extension BaseAnchorViewController {
   @objc func loadData(){
       
    }
}


//遵循UICollectionViewDateSource&UICollectionViewDelegate方法
extension BaseAnchorViewController: UICollectionViewDataSource,UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return baseVM.anchorGroups.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return baseVM.anchorGroups[section].anchors.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! CollectionNormalCell
        
        cell.anchor = baseVM.anchorGroups[indexPath.section].anchors[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath) as! CollectionHeaderView
        
        headerView.group = baseVM.anchorGroups[indexPath.section]
        return headerView
    }
    
}

