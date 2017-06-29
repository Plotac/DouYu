//
//  NSDate+Extension.swift
//  DouYu
//
//  Created by Plo on 2017/6/28.
//  Copyright © 2017年 Plo. All rights reserved.
//

import Foundation

extension NSDate {

    class func getCurrentTimeInterval() -> String {
        
        let nowDate = NSDate()
        let interval = Int(nowDate.timeIntervalSince1970)
        
        return String(interval)
    }
}
