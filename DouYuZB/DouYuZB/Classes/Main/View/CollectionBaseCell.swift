//
//  CollectionBaseCellCollectionViewCell.swift
//  DouYuZB
//
//  Created by huarong on 2018/3/27.
//  Copyright © 2018年 huarong. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionBaseCell: UICollectionViewCell {
    //MARK:控件属性
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var onlineBtn: UIButton!
    @IBOutlet weak var nickNameLabel: UILabel!
    
    //MARK:定义模型属性
    var anchor: AnchorModel?{
        didSet{
            //1.校验模型是否有值
            guard let anchor = anchor else {
                return
            }
            //2.取出在线人数显示文字
            var onlineStr: String = ""
            if anchor.online >= 10000 {
                onlineStr = "\(Int(anchor.online / 10000)) 万在线"
            }else{
                onlineStr = "\(anchor.online)在线"
            }
            onlineBtn.setTitle(onlineStr, for: .normal)
            //3.昵称的显示
            nickNameLabel.text = anchor.nickname
            //4.设置封面图片
            guard let url = URL(string: anchor.vertical_src) else {
                return
            }
            iconImageView.kf.setImage(with: ImageResource(downloadURL: url))
//            iconImageView.downloadedFrom(url: url)
        }
    }
}
