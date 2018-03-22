//
//  UIBarButtonItem-extension.swift
//  DouYuZB
//
//  Created by huarong on 2018/3/21.
//  Copyright © 2018年 huarong. All rights reserved.
//

//import Foundation

import UIKit

/*如何抽取呢？
 在OC中我们通常给系统的类抽取分类，在分类中给系统的类扩充方法
 Swift也是类似，只是Swift使用extension，表示对系统的类进行扩充
 */

extension UIBarButtonItem {
    //便利构造函数：
    //1.构造函数前以convenience开头
    //2.必须明确调用设计构造函数：例如self.init()
    
    
    convenience init(imageName: String, highImageName: String = "", size: CGSize = .zero ,target : AnyObject? = nil, action : Selector){
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), for: .normal)
        if highImageName != "" {
            btn.setImage(UIImage(named: highImageName), for: .highlighted)
        }
        if size == .zero {
            btn.sizeToFit()
        }else{
            btn.frame = CGRect(origin: .zero, size: size)
        }
        btn.addTarget(target, action: action, for: .touchUpInside)
        
        self.init(customView: btn)
    }
}
