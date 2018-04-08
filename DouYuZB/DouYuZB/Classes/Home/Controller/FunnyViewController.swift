//
//  FunnyViewController.swift
//  DouYuZB
//
//  Created by huarong on 2018/4/7.
//  Copyright © 2018年 huarong. All rights reserved.
//

import UIKit

private let kSectionMargin: CGFloat = 8

class FunnyViewController: BaseAnchorViewController {
    //懒加载ViewModel
    fileprivate lazy var funnyVM: FunnyViewModel = FunnyViewModel()
}

extension FunnyViewController {
    override func setupUI() {
        super.setupUI()
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.headerReferenceSize = .zero
        collectionView.contentInset = UIEdgeInsets(top: kSectionMargin, left: 0, bottom: 0, right: 0)
    }
}

extension FunnyViewController {
    override func loadData() {
        //1.给父类ViewModel赋值
        baseVM = funnyVM
        //2.请求数据
        funnyVM.loadFunnyData {
            self.collectionView.reloadData()
            //数据加载完成
            self.finishLoadData()
        }
    }
}
