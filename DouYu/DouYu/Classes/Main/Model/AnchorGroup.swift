//
//  AnchorGroup.swift
//  DouYu
//
//  Created by Plo on 2017/6/28.
//  Copyright © 2017年 Plo. All rights reserved.
//

import UIKit

class AnchorGroup: NSObject {
    
    /*方法2
    var room_list : [[String : NSObject]]? {
        didSet {//属性监听器，当属性有变化时会调用
            guard let room_list = room_list else { return }
            for dict in room_list {
                anchors.append(AnchorModel(dict: dict))
            }
        }
    }
    */
    //主播房间列表
    var room_list : [[String : NSObject]]?
    //组头图标
    var icon_url : String = ""
    //分类名称
    var tag_name : String = ""
    //主播model对应的数组
    lazy var anchors : [AnchorModel] = [AnchorModel]()
    
    init(dict : [String : NSObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    
    //方法1
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "room_list" {
            if let dataArray = value as? [[String : NSObject]] {
                for dict in dataArray {
                    anchors.append(AnchorModel(dict: dict))
                }
            }
        }
    }
}
