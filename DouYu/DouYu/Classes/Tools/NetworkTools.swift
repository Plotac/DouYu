//
//  NetworkTools.swift
//  DouYu
//
//  Created by Plo on 2017/6/28.
//  Copyright © 2017年 Plo. All rights reserved.
//

import UIKit
import Alamofire

enum MethodRequestType {
    case get
    case post
}

class NetworkTools {

    class func requestData(type : MethodRequestType ,urlString : String!, parameters : [String:Any]? = nil ,finishedCallback :@escaping (_ result : Any) -> ()){
    
        let httpMethod = type == .get ? HTTPMethod.get : HTTPMethod.post
        
        
        Alamofire.request(urlString,method:httpMethod,parameters:parameters).responseJSON { (response) in
            
            guard let result = response.result.value else {
            
                print(response.result.error as Any)
                return
            
            }
            finishedCallback(result)
            
        }
    }
    
    
}
