//
//  RoomPushViewController.swift
//  DouYuZB
//
//  Created by huarong on 2018/4/7.
//  Copyright © 2018年 huarong. All rights reserved.
//

import UIKit

class RoomPushViewController: UIViewController,UIGestureRecognizerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.green
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //1.隐藏导航栏
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        //2.依然保存手势
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //1.显示导航栏
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
}
