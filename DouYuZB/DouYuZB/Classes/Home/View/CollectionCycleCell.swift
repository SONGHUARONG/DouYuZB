//
//  CollectionCycleCell.swift
//  DouYuZB
//
//  Created by huarong on 2018/3/28.
//  Copyright © 2018年 huarong. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionCycleCell: UICollectionViewCell {
    //控件属性
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    //定义模型属性
    var cycleModel: CycleModel?{
        didSet {
            titleLabel.text = cycleModel?.title
            if let url = URL(string: cycleModel?.pic_url ?? "") {
                iconImageView.kf.setImage(with: ImageResource(downloadURL: url))
            }else {
                iconImageView.image = UIImage(named: "Img_default")
            }
            
        }
    }

}
