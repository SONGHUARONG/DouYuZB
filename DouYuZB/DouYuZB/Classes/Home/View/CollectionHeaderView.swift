//
//  CollectionHeaderViewCollectionReusableView.swift
//  DouYuZB
//
//  Created by huarong on 2018/3/24.
//  Copyright © 2018年 huarong. All rights reserved.
//

import UIKit

class CollectionHeaderView: UICollectionReusableView {
    
    @IBOutlet weak var headerName: UILabel!
    
    @IBOutlet weak var headerImageView: UIImageView!
    
    @IBOutlet weak var moreBtn: UIButton!
    var group: AnchorGroup? {
        didSet {
            self.headerName.text = group?.tag_name
            self.headerImageView.image = UIImage(named: group?.icon_name ?? "home_header_normal")
        }
    }
}
//MARK:提供快速创建CollectionHeaderView方法
extension CollectionHeaderView {
    class func collectionHeaderView() -> CollectionHeaderView {
        return Bundle.main.loadNibNamed("CollectionHeaderView", owner: nil, options: nil)?.first as! CollectionHeaderView
    }
}
