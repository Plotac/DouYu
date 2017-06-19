//
//  MainViewController.swift
//  DouYu
//
//  Created by Plo on 2017/6/9.
//  Copyright © 2017年 Plo. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        addChildVcIntoTabBarController(childVCName: "Home")
        addChildVcIntoTabBarController(childVCName: "Live")
        addChildVcIntoTabBarController(childVCName: "Focus")
        addChildVcIntoTabBarController(childVCName: "Found")
        addChildVcIntoTabBarController(childVCName: "Mine")
    }
    
    private func addChildVcIntoTabBarController(childVCName:String) {
    
        //通过StoryBoard获取控制器
        let childVC = UIStoryboard(name: childVCName, bundle: nil).instantiateInitialViewController()!
        
        //将childVC作为子控制器
        addChildViewController(childVC)
    }

}
