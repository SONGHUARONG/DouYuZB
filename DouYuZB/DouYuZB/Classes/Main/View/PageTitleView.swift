//
//  PageTitleView.swift
//  DouYuZB
//
//  Created by huarong on 2018/3/22.
//  Copyright © 2018年 huarong. All rights reserved.
//封装顶部的PageTitleView


import UIKit

protocol PageTitleViewDelegate: class {
    func pageTitleView(pageTitleView: PageTitleView, selectedIndex index: Int)
}

// MARK:- 定义常量
private let kScrollLineH : CGFloat = 2
private let kNormalColor: (CGFloat,CGFloat,CGFloat) = (85,85,85)
private let kSelectColor: (CGFloat,CGFloat,CGFloat) = (255,128,0)

class PageTitleView: UIView {

    private var titles: [String]
    private var currentIndex: Int = 0
    weak var delegate: PageTitleViewDelegate?
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        return scrollView
    }()
    
    private lazy var titleLabels: [UILabel] = [UILabel]()

    private lazy var scrollLine: UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        return scrollLine
    }()
    
    
    // MARK:- 构造函数
    init(frame: CGRect,titles: [String]) {
        self.titles = titles
        
        super.init(frame: frame)
        
        //更新UI界面
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PageTitleView{
    private func setupUI(){
        // 1.添加scrollView
        self.addSubview(scrollView)
        scrollView.frame = bounds
        // 2.初始化labels
        setupTitleLabels()
        // 3.添加定义的线段和滑动的滑块
        setupBottomlineAndScrollline()
    }
    
    private func setupTitleLabels() {
        let labelY: CGFloat = 0
        let labelW: CGFloat = frame.width / CGFloat(titles.count)
        let labelH: CGFloat = frame.height - kScrollLineH
        for (index,title) in titles.enumerated(){
            //1.创建UILabel
            let label = UILabel()
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16.0)
            label.textAlignment = .center
            label.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
            
            let labelX: CGFloat = labelW * CGFloat(index)
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            scrollView.addSubview(label)
            titleLabels.append(label)
            
            label.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action:#selector(self.clickLabel(_:)))
            label.addGestureRecognizer(tapGes)
        }
    }
    private func setupBottomlineAndScrollline() {
        // 1.添加底线
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
        let lineH : CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
        addSubview(bottomLine)
        
        // 2.添加scrollLine
        // 2.1.获取第一个Label
        guard let firstLabel = titleLabels.first else {
            return
        }
        firstLabel.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        // 2.2.设置scrollLine的属性
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - kScrollLineH, width: firstLabel.frame.width, height: kScrollLineH)
    }
    
}

//MARK: 监听label点击事件
extension PageTitleView{
    @objc private func clickLabel(_ tapGes: UITapGestureRecognizer){
        //1.获取之前label和当前label
        guard let currentLabel = tapGes.view as? UILabel else {return}
        let oldLabel = titleLabels[currentIndex]
        
        //2.改变字体颜色
        currentLabel.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        oldLabel.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
        
        //3.保存最新label下标
        currentIndex = currentLabel.tag
        
        //4.scrolline位置改变
        let scrollineX = CGFloat(currentIndex) * self.scrollLine.frame.width
        UIView.animate(withDuration: 0.2) {
            self.scrollLine.frame.origin.x = scrollineX
        }
        //发送通知
        delegate?.pageTitleView(pageTitleView: self, selectedIndex: currentIndex)
    }
}

//MARK:对外暴露方法
extension PageTitleView{
    func setTitleWithProgress(progress: CGFloat, sourceIndex: Int, targetIndex: Int){
        //1.取出sourceLabel,targetLabel
        let sourceLabel = titleLabels[sourceIndex]
        let targetLabel = titleLabels[targetIndex]
        
        //2.处理滑块逻辑
        let moveTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveX = moveTotalX * progress
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + moveX
        
        //3.处理文字渐变
        //3.1取出变化范围
        let colorDelta = (kSelectColor.0 - kNormalColor.0,kSelectColor.1 - kNormalColor.1,kSelectColor.2 - kNormalColor.2)
        //3.2变化sourceLabel
        sourceLabel.textColor = UIColor(r: kSelectColor.0 - colorDelta.0 * progress, g: kSelectColor.1 - colorDelta.1 * progress, b: kSelectColor.2 - colorDelta.2 * progress)
        //3.3变化targetLabel
        targetLabel.textColor = UIColor(r: kNormalColor.0 + colorDelta.0 * progress, g: kNormalColor.1  + colorDelta.1 * progress, b: kNormalColor.2 + colorDelta.2 * progress)
        //4.记录最新index
        currentIndex = targetIndex
    }
}
