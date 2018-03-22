//
//  PageContentView.swift
//  DouYuZB
//
//  Created by huarong on 2018/3/22.
//  Copyright © 2018年 huarong. All rights reserved.
//

import UIKit

let kContentCellID = "kContentCellID"

class PageContentView: UIView {
    
    private var childVcs : [UIViewController]
    private var parentVc: UIViewController
    
    private lazy var collectionView: UICollectionView = {
       
        //1.创建布局
        let collectionLayout = UICollectionViewFlowLayout()
        collectionLayout.itemSize = self.bounds.size
        collectionLayout.minimumLineSpacing = 0
        collectionLayout.minimumInteritemSpacing = 0
        collectionLayout.scrollDirection = .horizontal
        
        //2.创建collectionView
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionLayout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.scrollsToTop = false
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(NSClassFromString("UICollectionViewCell"), forCellWithReuseIdentifier: kContentCellID)
        return collectionView
        
    }()
    
    // MARK:- 构造函数
    init(frame: CGRect,childVcs: [UIViewController],parentVc: UIViewController) {
        self.childVcs = childVcs
        self.parentVc = parentVc
        
        super.init(frame: frame)
        //更新ui
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PageContentView: UICollectionViewDataSource,UICollectionViewDelegate {
    private func setupUI(){
        // 1.添加所有的控制器
        for childVc in childVcs {
            parentVc.addChildViewController(childVc)
        }
        // 2.添加collectionView
        addSubview(collectionView)
        collectionView.frame = bounds
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kContentCellID, for: indexPath)
        //因为cell复用，所以使用前先移除cell中所有view
        for subview in cell.contentView.subviews {
            subview.removeFromSuperview()
        }
        
        let childVc = childVcs[indexPath.item]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        
        
        return cell
    }
    
}
