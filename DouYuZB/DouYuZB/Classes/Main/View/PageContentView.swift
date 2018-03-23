//
//  PageContentView.swift
//  DouYuZB
//
//  Created by huarong on 2018/3/22.
//  Copyright © 2018年 huarong. All rights reserved.
//

import UIKit

let kContentCellID = "kContentCellID"

protocol PageContentViewDelegate: class {
    func pageContentView(pageContentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int)
}

class PageContentView: UIView {
    
    private var childVcs : [UIViewController]
    private weak var parentVc: UIViewController?
    private var startOffsetX: CGFloat = 0
    weak var delegate: PageContentViewDelegate?
    private var isForbidScrollDelegate: Bool = false
    
    private lazy var collectionView: UICollectionView = { [weak self] in
       
        //1.创建布局
        let collectionLayout = UICollectionViewFlowLayout()
        collectionLayout.itemSize = (self?.bounds.size)!
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
    init(frame: CGRect,childVcs: [UIViewController],parentVc: UIViewController?) {
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

//遵循UICollectionViewDataSource
extension PageContentView: UICollectionViewDataSource {
    private func setupUI(){
        // 1.添加所有的控制器
        for childVc in childVcs {
            parentVc?.addChildViewController(childVc)
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

//遵循UICollectionViewDelegate
extension PageContentView: UICollectionViewDelegate{
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isForbidScrollDelegate = false
        
        startOffsetX = scrollView.contentOffset.x
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 0.判断是否是点击事件
        if isForbidScrollDelegate {return}
        
        //1.定义需要的变量
        var progress: CGFloat = 0
        var sourceIndex: Int = 0
        var targetIndex: Int = 0
        
        //2.判断左滑还是右滑
        let currentOffsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        if currentOffsetX > startOffsetX {//左滑
            //1.计算progress
            progress = currentOffsetX/scrollViewW - floor(currentOffsetX/scrollViewW)
            //2.计算sourceIndex
            sourceIndex = Int(currentOffsetX / scrollViewW)
            //3.计算targetIndex
            targetIndex = sourceIndex + 1
            if targetIndex >= childVcs.count {
                targetIndex = childVcs.count - 1
            }
            //4.如果完全滑过去
            if currentOffsetX - startOffsetX == scrollViewW {
                progress = 1
                targetIndex = sourceIndex
            }
        }else{//右滑
            //1.计算progress
            progress = 1 - (currentOffsetX/scrollViewW - floor(currentOffsetX/scrollViewW))
            //2.计算targetIndex
            targetIndex = Int(currentOffsetX / scrollViewW)
            //3.计算sourceIndex
            sourceIndex = targetIndex + 1
            if sourceIndex >= childVcs.count {
                sourceIndex = childVcs.count - 1
            }
        }
        
        //3.将progress/sourceIndex/targetIndex发送给pageTitleView
        delegate?.pageContentView(pageContentView: self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}


//MARK:暴露对外方法
extension PageContentView{
    func setCurrentIndex(currentIndex: Int){
        //1.记录需要禁止代理方法
        isForbidScrollDelegate = true
        //2.滚到正确的位置
        let offsetX = CGFloat(currentIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
    }
}
