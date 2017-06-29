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
    fileprivate lazy var anchorGroups : [AnchorGroup] = [AnchorGroup]()
    
    //存放具体分类组中主播信息的数组
    fileprivate lazy var anchors : [AnchorModel] = [AnchorModel]()
}

extension RecommendViewModel {

    func requestData() {
        
        let parameters = [
                          "limit":"4",
                          "offset":"0",
                          "time":NSDate.getCurrentTimeInterval()
                          ]
        print(NSDate.getCurrentTimeInterval())
        //1.请求第一部分推荐数据
        
        
        //2.请求第二部分颜值数据
//        http://capi.douyucdn.cn/api/v1/getVerticalRoom?limit=4&offset=0&time=1498643686
        NetworkTools.requestData(type: .get, urlString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", parameters: parameters) { (response) in

            guard let dataDic = response as? [String : NSObject] else { return }
            
            guard let dataArray = dataDic["data"] as? [[String : NSObject]] else { return }
            
            for dict in dataArray {
                let anchor = AnchorModel(dict: dict)
            }
        }
        
        //3.请求最后部分游戏数据
//        http://capi.douyucdn.cn/api/v1/getHotCate?limit=4&offset=0&time=1498642288
        NetworkTools.requestData(type: .get, urlString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: parameters) { (response) in
            
            guard let dataDic = response as? [String : NSObject] else { return }
            
            guard let dataArray = dataDic["data"] as? [[String : NSObject]] else { return }

            //字典转模型
            for dic in dataArray {
                let group = AnchorGroup(dict: dic)
                self.anchorGroups.append(group)
            }
         
            for group in self.anchorGroups {
                for anchor in group.anchors {
                    self.anchors.append(anchor)
                }
            }
            
        }
        
    }


}
