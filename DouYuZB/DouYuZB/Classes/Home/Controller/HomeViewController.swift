//
//  HomeViewController.swift
//  DouYuZB
//
//  Created by huarong on 2018/3/21.
//  Copyright © 2018年 huarong. All rights reserved.
//

import UIKit

let kPageTitleViewH: CGFloat = 40

class HomeViewController: UIViewController {
    
    private lazy var pageTitleView: PageTitleView = {
        let frame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH, width: kScreenW, height: kPageTitleViewH)
        let titles = ["推荐", "游戏", "娱乐", "趣玩"]
        let pageTitleView = PageTitleView(frame: frame, titles: titles)
        return pageTitleView
    }()
    
    private lazy var pageContentView: PageContentView = {
        let contentH = kScreenH - kStatusBarH - kNavigationBarH - kPageTitleViewH - kTabbarH
        let contentFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH + kPageTitleViewH, width: kScreenW, height: contentH)
        var childVcs = [UIViewController]()
        for _ in 0..<4 {
            let childVc = UIViewController()
            childVc.view.backgroundColor = UIColor.randomColor()
            childVcs.append(childVc)
        }
        
       let pageContentView = PageContentView(frame: contentFrame, childVcs: childVcs, parentVc: self)
        return pageContentView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        //更新ui界面
        setupUi()
    }
    

}



extension HomeViewController {
    private func setupUi(){
        // 0.不需要调整UIScrollView的内边距
        automaticallyAdjustsScrollViewInsets = false
        // 1.设置导航栏
        setupNavigationBar()
        // 2.添加TitleView
        self.view.addSubview(pageTitleView)
        // 3.添加contentView
        self.view.addSubview(pageContentView)
    }
    private func setupNavigationBar(){
//        self.navigationController?.navigationBar.backgroundColor = UIColor.black
        setupNavigationLeftBar()
        setupNavigationRightBar()
        setupNavigationTitleView()
    }
    private func setupNavigationLeftBar(){
        let size = CGSize(width: 40, height: 40)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo", highImageName: "", size: size, target: self, action: #selector(self.clickLeftBar))
    }
    private func setupNavigationRightBar(){
        let size = CGSize(width: 40, height: 40)
        
        let historyItem = UIBarButtonItem(imageName: "image_my_history", highImageName: "image_my_history_click", size: size, target: self, action: #selector(self.historyItemClick))
        let searchItem = UIBarButtonItem(imageName: "btn_search", highImageName: "btn_search_click", size: size, target: self, action: #selector(self.searchItemClick))
        let qrCodeItem = UIBarButtonItem(imageName: "Image_scan", highImageName: "Image_scan_click", size: size, target: self, action: #selector(self.qrCodeItemClick))
        
        navigationItem.rightBarButtonItems = [historyItem, searchItem , qrCodeItem]
    }
    
    private func setupNavigationTitleView(){
        self.navigationItem.titleView = nil
    }
    
    @objc func clickLeftBar(_ leftBtn: UIBarButtonItem){
        print("click left bar")
    }
    @objc func historyItemClick(_ historyBtn: UIBarButtonItem){
        print("click history btn")
    }
    @objc func searchItemClick(_ searchBtn: UIBarButtonItem){
        print("click search btn")
    }
    @objc func qrCodeItemClick(_ qrCodeBtn: UIBarButtonItem){
        print("click qrCode btn")
    }
    
}
