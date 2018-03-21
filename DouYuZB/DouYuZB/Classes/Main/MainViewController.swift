//
//  MainViewController.swift
//  DouYuZB
//
//  Created by huarong on 2018/3/21.
//  Copyright © 2018年 huarong. All rights reserved.
//

import Foundation
import UIKit

class MainViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
                
        addChildVcWithStoryBoardName("Home")
        addChildVcWithStoryBoardName("Living")
        addChildVcWithStoryBoardName("Focus")
        addChildVcWithStoryBoardName("Discovery")
        addChildVcWithStoryBoardName("Mine")
        
    }
    
    
    
    
}

extension MainViewController {
    private func addChildVcWithStoryBoardName(_ storyBoardName: String){
        let childVc = UIStoryboard(name: storyBoardName, bundle: nil).instantiateInitialViewController()!
        addChildViewController(childVc)
    }
}
