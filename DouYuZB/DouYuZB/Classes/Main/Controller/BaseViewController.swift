//
//  BaseViewController.swift
//  DouYuZB
//
//  Created by huarong on 2018/4/7.
//  Copyright © 2018年 huarong. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    //保存collectionView的引用
    var contentView: UIView?
    //懒加载属性
    lazy var animateImageView: UIImageView = {
        let animateImageView = UIImageView(image: UIImage(named: "img_loading_1"))
        animateImageView.autoresizingMask = [.flexibleTopMargin,.flexibleBottomMargin]
        animateImageView.center = self.view.center
        animateImageView.animationImages = [UIImage(named: "img_loading_1")!,UIImage(named: "img_loading_2")!]
        animateImageView.animationDuration = 0.3
        animateImageView.animationRepeatCount = LONG_MAX
        return animateImageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //设置UI界面
        setupUI()
    }
}

extension BaseViewController {
    @objc func setupUI(){
        //1.将contentView隐藏
        contentView?.isHidden = true
        //2.将animateImageView加入到控制器view中
        view.addSubview(animateImageView)
        //3.开启动画
        animateImageView.startAnimating()
        //4.设置view背景颜色
        self.view.backgroundColor = UIColor(r: 250, g: 250, b: 250)
    }
    
    func finishLoadData(){
        //1.停止动画
        animateImageView.stopAnimating()
        //2.隐藏animateImageView
        animateImageView.isHidden = true
        //3.显示contentView
        contentView?.isHidden = false
    }
}
