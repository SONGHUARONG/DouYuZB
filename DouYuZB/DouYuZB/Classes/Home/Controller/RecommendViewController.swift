//
//  RecommendViewController.swift
//  DouYuZB
//
//  Created by huarong on 2018/3/23.
//  Copyright © 2018年 huarong. All rights reserved.
//

import UIKit

//MARK:定义一些常量


private let kCycleViewH: CGFloat = kScreenW * 3 / 8
private let kGameViewH: CGFloat = 90



//定义RecommendViewController类
class RecommendViewController: BaseAnchorViewController {

    fileprivate lazy var recommendVM: RecommendViewModel = RecommendViewModel()
    fileprivate lazy var cycleView: RecommendCycleView = {
        let cycleView = RecommendCycleView.recommendCycleView()
        cycleView.frame = CGRect(x: 0, y: -(kCycleViewH + kGameViewH), width: kScreenW, height: kCycleViewH)
        return cycleView
    }()
    
    fileprivate lazy var gameView: RecommendGameView = {
        let gameView = RecommendGameView.recommendGameView()
        gameView.frame = CGRect(x: 0, y: -kGameViewH, width: kScreenW, height: kGameViewH)
        return gameView
    }()
    
   
    
}

//MARK:请求数据
extension RecommendViewController{
    override func loadData(){
        //0.给父类ViewModel赋值
        baseVM = recommendVM
        
        //1.请求推荐数据
        recommendVM.requestData {
            //1.展示推荐数据
            self.collectionView.reloadData()
            //2.将数据传递给gameView
            var groups = self.recommendVM.anchorGroups
            //2.1 移除前2组数据
            groups.removeFirst()
            groups.removeFirst()
            //2.2 添加“更多”
            let moreGroup = AnchorGroup()
            moreGroup.tag_name = "更多"
            groups.append(moreGroup)
            
            self.gameView.groups = groups
            //3.数据加载完成
            self.finishLoadData()
        }
        //2.请求无限轮播数据
        recommendVM.requestCycleData {
            self.cycleView.cycleModels = self.recommendVM.cycleModels
        }
    }
}

//MARK:设置ui界面内容
extension RecommendViewController{
    override func setupUI(){
        //1.添加collectionView
        super.setupUI()
        //2.将cycleview添加到collectionview
        collectionView.addSubview(cycleView)
        //3.将gameView添加到collectionView中
        collectionView.addSubview(gameView)
        //4.设置collectionView的内边距
        collectionView.contentInset = UIEdgeInsets(top: kGameViewH + kCycleViewH , left: 0, bottom: 0, right: 0)
    }
}

//MARK:遵守UICollectionViewDataSource协议
extension RecommendViewController: UICollectionViewDelegateFlowLayout{
    
   
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 1 {
          let prettyCell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath) as! CollectionPrettyCell
            prettyCell.anchor = recommendVM.anchorGroups[indexPath.section].anchors[indexPath.item]
            return prettyCell
        }else{
          return super.collectionView(collectionView, cellForItemAt: indexPath)
        }
    }
    
   
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: kNormalItemW, height: kPrettyItemH)
        }
        return CGSize(width: kNormalItemW, height: kNormalItemH)
    }
}

