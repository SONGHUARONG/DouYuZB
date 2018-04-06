//
//  RecommendGameView.swift
//  DouYuZB
//
//  Created by huarong on 2018/3/28.
//  Copyright © 2018年 huarong. All rights reserved.
//

import UIKit

private let kGameCellID: String = "kGameCellID"
private let kUIEdgeInsets: CGFloat = 10

class RecommendGameView: UIView {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: 定义数据的属性
    var groups : [BaseGameModel]? {
        didSet {
            // 刷新表格
            collectionView.reloadData()
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //移除autoresizingMask，让RecommendGameView不随着控制器伸缩而变化
        //设置该控件不随着父控件的拉伸而拉伸
        self.autoresizingMask = UIViewAutoresizing()
        
        //添加内边距
        collectionView.contentInset = UIEdgeInsets(top: 0, left: kUIEdgeInsets, bottom: 0, right: kUIEdgeInsets)
        
        //注册cell
        collectionView.register(UINib.init(nibName: "CollectionGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCellID)
    }
    
}


//MARK:提供快速创建的类方法
extension RecommendGameView {
    class func recommendGameView() -> RecommendGameView {
        return Bundle.main.loadNibNamed("RecommendGameView", owner: nil, options: nil)?.first as! RecommendGameView
    }
}


//MARK:遵守UICollectionView数据源方法
extension RecommendGameView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath) as! CollectionGameCell
        
        cell.baseGame = groups![(indexPath as NSIndexPath).item]
        
        return cell
    }
    
    
}
