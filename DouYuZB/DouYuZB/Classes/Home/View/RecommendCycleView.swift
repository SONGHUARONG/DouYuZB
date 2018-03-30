//
//  RecommendCycleView.swift
//  DouYuZB
//
//  Created by huarong on 2018/3/27.
//  Copyright © 2018年 huarong. All rights reserved.
//

import UIKit

private let kCycleCellID: String = "kCycleCellID"

class RecommendCycleView: UIView {
    //定义模型属性
    var cycleModels: [CycleModel]? {
        didSet {
            //1.刷新collectionView
            collectionView.reloadData()
            
            //2.设置pageControl个数
            pageControl.numberOfPages = cycleModels?.count ?? 0
            
            //3.默认滚动到中间某一位置（为了第一张图片可以往前滚动到最后一张图片）
            let indexPath = IndexPath(item: (cycleModels?.count ?? 0) * 10, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .left, animated: true)
            
            //4.添加定时器
            removeCycleTimer()
            addCycleTimer()
        }
    }
    //定时器属性
    var cycleTimer: Timer?
    
    //控件属性
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // 设置该控件不随着父控件的拉伸而拉伸
        autoresizingMask = UIViewAutoresizing()
        
        collectionView.register(UINib(nibName: "CollectionCycleCell", bundle: nil), forCellWithReuseIdentifier: kCycleCellID)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        // 设置collectionView的layout
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size        
    }
    
}

//MARK:实现UICollectionView数据源方法
extension RecommendCycleView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //为了最后一张图片可以往后滚动到第一张图片(无限轮播)
        return (cycleModels?.count ?? 0) * 10000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCycleCellID, for: indexPath) as! CollectionCycleCell
        
        cell.cycleModel = cycleModels![(indexPath as NSIndexPath).item % cycleModels!.count]

        return cell
    }
    
}

//MARK:实现UICollectionView代理方法
extension RecommendCycleView: UICollectionViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeCycleTimer()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        addCycleTimer()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //1.获取滚动的偏移量
        let offsetX = scrollView.contentOffset.x + scrollView.bounds.width * 0.5
        //2.计算pageControl的当前currentIndex
        pageControl.currentPage = Int(offsetX / scrollView.bounds.width) % (cycleModels?.count ?? 1)
    }
}


//MARK:提供一个快速创建RecommendCycleView的类方法
extension RecommendCycleView {
    class func recommendCycleView() -> RecommendCycleView {
        return Bundle.main.loadNibNamed("RecommendCycleView", owner: nil, options: nil)?.first as! RecommendCycleView
    }
}

//MARK:对定时器的操作方法
extension RecommendCycleView {
    private func addCycleTimer(){
        cycleTimer = Timer(timeInterval: 3.0, target: self, selector: #selector(self.scrollToNext), userInfo: nil, repeats: true)
        RunLoop.main.add(cycleTimer!, forMode: .commonModes)
    }
    
    private func removeCycleTimer(){
        cycleTimer?.invalidate()//从运行循环中移除
        cycleTimer = nil
    }
    @objc private func scrollToNext(){
        //1.获取滚动的偏移量
        let currentOffsetX = collectionView.contentOffset.x
        let offsetX = currentOffsetX + collectionView.bounds.width
        
        //2.滚动该位置
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
}

