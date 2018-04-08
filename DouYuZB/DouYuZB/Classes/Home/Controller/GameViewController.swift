//
//  GameViewController.swift
//  DouYuZB
//
//  Created by huarong on 2018/4/1.
//  Copyright © 2018年 huarong. All rights reserved.
//

import UIKit
private let kEdgeMargin: CGFloat = 10
private let kItemW: CGFloat = (kScreenW - 2 * kEdgeMargin) / 3
private let kItemH: CGFloat = kItemW * 6 / 5
private let kHeaderViewH: CGFloat = 50
private let kGameViewH: CGFloat = 90
private let kGameCellID = "kGameCellID"
private let kHeaderViewID = "kHeaderViewID"

class GameViewController: BaseViewController {
    fileprivate lazy var gameVM: GameViewModel = GameViewModel()
    fileprivate lazy var topHeaderView: CollectionHeaderView = {
        let topHeaderView = CollectionHeaderView.collectionHeaderView()
        topHeaderView.frame = CGRect(x: 0, y: -(kHeaderViewH + kGameViewH), width: kScreenW, height: kHeaderViewH)
        topHeaderView.headerImageView.image = UIImage(named: "Img_orange")
        topHeaderView.headerName.text = "常用"
        topHeaderView.moreBtn.isHidden = true
        return topHeaderView
    }()
    
    
    fileprivate lazy var gameView: RecommendGameView = {
        let gameView = RecommendGameView.recommendGameView()
        gameView.frame = CGRect(x: 0, y: -kGameViewH, width: kScreenW, height: kGameViewH)
        return gameView
    }()
    
    fileprivate lazy var collectionView: UICollectionView = {[unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: kEdgeMargin, bottom: 0, right: kEdgeMargin)
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "CollectionGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCellID)
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        //1.设置ui界面
        setupUI()
        //2.请求数据
        loadData()
    }

}


//MARK:设置UI界面
extension GameViewController {
     override func setupUI(){
        //0.给父类contentView赋值
        contentView = collectionView
        //1.添加collectionView
        view.addSubview(collectionView)
        //2.将topHeaderView添加到collectionView
        collectionView.addSubview(topHeaderView)
        //3.将"常用"gameView加入collectionView
        collectionView.addSubview(gameView)
        //3.设置collectionView内边距
        collectionView.contentInset = UIEdgeInsets(top: kHeaderViewH + kGameViewH, left: 0, bottom: 0, right: 0)
        //3.调用父类super.setupUI()
        super.setupUI()
    }
}

//MARK:请求数据
extension GameViewController {
    fileprivate func loadData(){
        
        
        gameVM.loadAllGameData(finishCallBack: {
            //1.展示全部游戏
            self.collectionView.reloadData()
            //2.展示常用游戏
            //            var tempArry = [BaseGameModel]()
            //            let groups = self.gameVM.gameModels
            //            for group in groups[0..<10] {
            //                tempArry.append(group)
            //            }
            //            self.gameView.groups = tempArry
            self.gameView.groups = Array(self.gameVM.gameModels[0..<10])
            //3.数据加载完成
            self.finishLoadData()
        })
        
        
    }
}

//MARK:遵循UICollectionView数据源方法
extension GameViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameVM.gameModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath) as! CollectionGameCell
        cell.baseGame = gameVM.gameModels[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath) as! CollectionHeaderView
        headerView.headerName.text = "全部"
        headerView.headerImageView.image = UIImage(named: "Img_orange")
        headerView.moreBtn.isHidden = true
        return headerView
    }
    
}

