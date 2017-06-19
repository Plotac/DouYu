//
//  UIBarButtonItem+Extension.swift
//  DouYu
//
//  Created by Plo on 2017/6/14.
//  Copyright © 2017年 Plo. All rights reserved.
//

import UIKit

extension UIBarButtonItem {

    /*类方法
    class func dy_barButtonItem(imageName:String,highlightedImageName:String,itemSize:CGSize) -> UIBarButtonItem {
    
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named:imageName), for: .normal)
        button.setImage(UIImage(named:highlightedImageName), for: .highlighted)
        button.frame = CGRect(origin: CGPoint.zero, size: itemSize)
        
        return UIBarButtonItem(customView: button)
    }
    */
    
    //swift中推荐使用 便利构造函数
    /*
      必须满足两个条件：1.convenience开头 
                    2.必须在函数中明确调用一个设计构造函数(这里是UIBarButtonItem(customView:)这个函数）
                    3.该设计函数必须使用self调用
    */
    convenience init(imageName:String, highlightedImageName:String = "", itemSize:CGSize = CGSize.zero) {
        let button = UIButton(type: .custom)
        
        button.setImage(UIImage(named:imageName), for: .normal)
        
        if highlightedImageName != "" {
            button.setImage(UIImage(named:highlightedImageName), for: .highlighted)
        }
        if itemSize == CGSize.zero {
            button.sizeToFit()
        }else {
            button.frame = CGRect(origin: CGPoint.zero, size: itemSize)
        }
        
        self.init(customView:button)
    }



}
