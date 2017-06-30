//
//  RecommendViewModel.swift
//  DouYu
//
//  Created by Plo on 2017/6/28.
//  Copyright © 2017年 Plo. All rights reserved.
//

import UIKit

class RecommendViewModel {
    //懒加载属性
    //存放分类组的数组
    lazy var anchorGroups : [AnchorGroup] = [AnchorGroup]()
    fileprivate lazy var recommendGroup : AnchorGroup = AnchorGroup()
    fileprivate lazy var prettyGroup : AnchorGroup = AnchorGroup()
    
}

extension RecommendViewModel {

    func requestData(finishedCallback:@escaping () -> ()) {
    
        print(NSDate.getCurrentTimeInterval())
        //1.请求第一部分推荐数据
//        http://capi.douyucdn.cn/api/v1/getbigDataRoom?time=1498643686
        let gcdGroup = DispatchGroup()
        DispatchGroup.enter(gcdGroup)()
        NetworkTools.requestData(type: .get, urlString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters: ["time":NSDate.getCurrentTimeInterval()]) { (response) in
            
            guard let dataDic = response as? [String : NSObject] else { return }
            
            guard let dataArray = dataDic["data"] as? [[String : NSObject]] else { return }
            
            //设置组属性
            self.recommendGroup.tag_name = "热门"
            self.recommendGroup.small_icon_url = "HeadViewHotIcon"
            //字典转模型
            for dict in dataArray {
                let anchor = AnchorModel(dict: dict)
                self.recommendGroup.anchors.append(anchor)
            }
            DispatchGroup.leave(gcdGroup)()
        }
        
        
        //2.请求第二部分颜值数据
        let parameters = [
            "limit":"4",
            "offset":"0",
            "time":NSDate.getCurrentTimeInterval()
        ]
//        http://capi.douyucdn.cn/api/v1/getVerticalRoom?limit=4&offset=0&time=1498643686
        DispatchGroup.enter(gcdGroup)()
        NetworkTools.requestData(type: .get, urlString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", parameters: parameters) { (response) in

            guard let dataDic = response as? [String : NSObject] else { return }
            
            guard let dataArray = dataDic["data"] as? [[String : NSObject]] else { return }

            //设置组属性
            self.prettyGroup.tag_name = "颜值"
            self.prettyGroup.small_icon_url = "YanzhiIcon"
            //字典转模型
            for dict in dataArray {
                let anchor = AnchorModel(dict: dict)
                self.prettyGroup.anchors.append(anchor)
            }

            DispatchGroup.leave(gcdGroup)()
        }
        
        //3.请求最后部分游戏数据
//        http://capi.douyucdn.cn/api/v1/getHotCate?limit=4&offset=0&time=1498642288
        DispatchGroup.enter(gcdGroup)()
        NetworkTools.requestData(type: .get, urlString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: parameters) { (response) in
            
            guard let dataDic = response as? [String : NSObject] else { return }
            
            guard let dataArray = dataDic["data"] as? [[String : NSObject]] else { return }

            //字典转模型
            for dic in dataArray {
                let group = AnchorGroup(dict: dic)
                self.anchorGroups.append(group)
            }

            DispatchGroup.leave(gcdGroup)()
        }
        
        gcdGroup.notify(queue: DispatchQueue.main) { 
            self.anchorGroups.insert(self.prettyGroup, at: 0)
            self.anchorGroups.insert(self.recommendGroup, at: 0)
            
            finishedCallback()
        }
        
    }


}
