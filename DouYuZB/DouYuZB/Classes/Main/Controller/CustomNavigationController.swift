//
//  CustomNavigationController.swift
//  DouYuZB
//
//  Created by huarong on 2018/4/7.
//  Copyright © 2018年 huarong. All rights reserved.
//

import UIKit
/*
 
 添加全屏Pop手势
 思路分析：添加全屏Pop手势一直以来都有两种实现思路
 方式一：自己在Push出来的View中添加UIPanGestureRecognizer手势
 添加手势，监听手势滑动
 随着手势滑动，逐渐退出控制器的View
 优点：最容易想到，使用自定义专场即可实现
 缺点：较为麻烦
 方式二：利用运行时机制，获取系统的Pop手势target&action
 获取系统的手势监听View
 获取系统的手势target&action
 创建自己的手势，添加事件监听时，使用上步中的target&action
 将手势，添加到系统手势监听的View中
 优点：实现非常简单
 缺点：需要用到运行时机制，且不容易想到
 
 
 (1)首先，我们已经知道系统是有一个左滑手势
 该左滑手势只能在左边缘滑动才会生效
 但是该手势的View&target&action系统已经创建好了
 我们可以自己创建一个手势，但是利用系统的View&target&action
 
 (2)问题？
 1> 如果获取系统手势的View？
 比如简单，因为可以直接获取interactivePopGestureRecognizer手势
 interactivePopGestureRecognizer.view即可获得
 2> 如果获取target&action
 该方式较为麻烦，需要使用KVC
 通过某一些Key来获取可接
 3> 通过哪些key呢？
 需要用运行时，遍历所有的属性找到
 */

class CustomNavigationController: UINavigationController {

    override func viewDidLoad() {
        // 1.获取系统的Pop手势
        guard let systemGes = interactivePopGestureRecognizer else { return }
        
        // 2.获取手势添加到的View中
        guard let gesView = systemGes.view else { return }
        
        // 3.获取target/action
        // 3.1.利用运行时机制查看所有的属性名称
        /*
         var count : UInt32 = 0
         let ivars = class_copyIvarList(UIGestureRecognizer.self, &count)!
         for i in 0..<count {
         let ivar = ivars[Int(i)]
         let name = ivar_getName(ivar)
         print(String(cString: name!))
         }
         */
        let targets = systemGes.value(forKey: "_targets") as? [NSObject]
        guard let targetObjc = targets?.first else { return }
        
        // 3.2.取出target
        guard let target = targetObjc.value(forKey: "target") else { return }
        
        // 3.3.取出Action
        let action = Selector(("handleNavigationTransition:"))
        
        // 4.创建自己的Pan手势
        let panGes = UIPanGestureRecognizer()
        gesView.addGestureRecognizer(panGes)
        panGes.addTarget(target, action: action)
        
        super.viewDidLoad()
    }

    override func pushViewController(_ viewController: UIViewController, animated: Bool){
        viewController.hidesBottomBarWhenPushed = true
        
        super.pushViewController(viewController, animated: animated)
    }

}
