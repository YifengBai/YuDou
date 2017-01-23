//
//  NetWorkTools.swift
//  YuDou
//
//  Created by Bemagine on 2017/1/16.
//  Copyright © 2017年 bemagine. All rights reserved.
//

import UIKit
import Alamofire


class NetWorkTools {
    
    class func loadData(URLString url: String, params: [String : Any]?, completeCallback: @escaping (_ result: Any) -> ()) {
        
        let urlString = "http://capi.douyucdn.cn/" + url
        
        Alamofire.request(urlString, method: .post, parameters: params).responseString { (response) in
            // 3.获取结果
            guard response.result.value != nil else {
                completeCallback(["failed":"获取数据失败"])
                return
            }
            
//            YFLog(message: result)
            
            }.responseJSON { (response) in
         
            // 3.获取结果
            guard let result = response.result.value else {
                YFLog(message: response.result.error)
                return
            }
            // 4.将结果回调出去
            completeCallback(result)
            
            
        }
    }
    
}
