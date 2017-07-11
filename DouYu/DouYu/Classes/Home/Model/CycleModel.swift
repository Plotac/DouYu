//
//  CycleModel.swift
//  DouYu
//
//  Created by Plo on 2017/6/30.
//  Copyright © 2017年 Plo. All rights reserved.
//

import UIKit

class CycleModel: NSObject {

    //标题
    var title : String = ""
    
    //图片
    var pic_url : String = ""
    
    //主播房间信息
    var room : [String : NSObject]? {
    
        didSet {
            guard let room = room else { return }
            anchor = AnchorModel(dict: room)
        }
    }
    
    //主播房间信息对应的model
    var anchor : AnchorModel?
    
    init(dict : [String : NSObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
