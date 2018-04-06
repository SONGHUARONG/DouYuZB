//
//  CollectionGameCell.swift
//  DouYuZB
//
//  Created by huarong on 2018/3/28.
//  Copyright © 2018年 huarong. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionGameCell: UICollectionViewCell {
    
    var baseGame: BaseGameModel?{
        didSet{
            titleLabel.text = baseGame?.tag_name
         
            if let iconUrl = URL(string: baseGame?.icon_url ?? "") {
                iconImageView.kf.setImage(with: ImageResource(downloadURL: iconUrl))
            }else {
                iconImageView.image = UIImage(named: "home_more_btn")
            }
        }
    }
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
}
