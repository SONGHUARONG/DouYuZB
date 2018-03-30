//
//  CollectionNormalCell.swift
//  DouYuZB
//
//  Created by huarong on 2018/3/24.
//  Copyright © 2018年 huarong. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionNormalCell: CollectionBaseCell {
    
    @IBOutlet weak var roomNameLabel: UILabel!
    
    override var anchor: AnchorModel?{
        didSet {
           super.anchor = anchor
            
            //所在的城市
            roomNameLabel.text = anchor?.room_name
           
        }
    }
    
   

}
