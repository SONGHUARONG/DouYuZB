//
//  CollectionPrettyCell.swift
//  DouYuZB
//
//  Created by huarong on 2018/3/24.
//  Copyright © 2018年 huarong. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionPrettyCell: CollectionBaseCell {

    //MARK:控件属性
    @IBOutlet weak var cityBtn: UIButton!
    //MARK:定义模型属性
    override var anchor: AnchorModel? {
        didSet {
            super.anchor = anchor
            //所在的城市
            cityBtn.setTitle(anchor?.anchor_city, for: .normal)
        }
    }
}
