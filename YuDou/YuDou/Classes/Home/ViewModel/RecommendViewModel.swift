//
//  RecommendViewModel.swift
//  YuDou
//
//  Created by Bemagine on 2017/1/20.
//  Copyright © 2017年 bemagine. All rights reserved.
//

import UIKit

class RecommendViewModel: BaseViewModel {

    /// 颜值数据
    fileprivate lazy var verticalData : BaseGroupRoomModel = BaseGroupRoomModel()
    /// 最热数据
    fileprivate lazy var bigHotData : BaseGroupRoomModel = BaseGroupRoomModel()
    
    // 轮播数据
    lazy var slideData : [SlideModel] = [SlideModel]()
    
}

extension RecommendViewModel {
    
    /// 获取顶部滚动视图数据
    func loadSliDate(_ finishedCallback: @escaping (_ success: Bool) -> ()) {
        // https://capi.douyucdn.cn/api/v1/slide/6?version=2.431&client_sys=ios
        let urlString = "api/v1/slide/6"
        NetWorkTools.loadData(URLString: urlString, params: ["version":"2.431", "client_sys":"ios"]) { (reponse) in
            
            guard let resultDict = reponse as? [String : Any] , let dataArray = resultDict["data"] as? [[String : Any]] else {
                finishedCallback(false)
                return
            }
            
            for dict in dataArray {
                let slideModel = SlideModel(dict: dict)
                self.slideData.append(slideModel)
            }

            finishedCallback(true)
        }
    }
    
    /// 获取推荐数据
    func loadRecommendData(_ finishedCallback: @escaping () -> ()) {
        
        // https://capi.douyucdn.cn/api/v1/getHotCate?aid=ios&client_sys=ios&time=1484883660&auth=639f85d408c74026eceaed9b69042a6b
        
        let GCDGroup = DispatchGroup()
        
        // 获取最热数据
        GCDGroup.enter()
        NetWorkTools.loadData(URLString: "api/v1/getbigDataRoom", params: ["client_sys" : "ios"]) { (result) in
            
            guard let resultDict = result as? [String : Any] else { return }
            guard let dataArray = resultDict["data"] as? [[String : Any]] else { return }
            
            self.bigHotData.tag_name = "最热"
            self.bigHotData.icon_name = "home_header_hot"
            
            for dict in dataArray {
                let roomModel = BaseRoomModel(dict: dict)
                self.bigHotData.anchors.append(roomModel)
            }
            
            GCDGroup.leave()
        }
        
        // 获取颜值数据
        GCDGroup.enter()
        NetWorkTools.loadData(URLString: "api/v1/getVerticalRoom", params: ["limit" : "4", "client_sys": "ios", "offset" : "0"]) { (result) in
            
            guard let resultDict = result as? [String : Any] else { return }
            guard let dataArray = resultDict["data"] as? [[String : Any]] else { return }
            
            self.verticalData.tag_name = "颜值"
            self.verticalData.icon_name = "home_header_phone"
            
            for (index, dict) in dataArray.enumerated() {
                let roomModel = BaseRoomModel(dict: dict)
                self.verticalData.anchors.append(roomModel)
                if index >= 3 { break }
            }
            
            GCDGroup.leave()
        }
        
        // 获取游戏数据
        let hotCateParams = ["aid" : "ios", "client_sys" : "ios", "time" : "\(Date().timeIntervalSince1970)"]
        GCDGroup.enter()
        NetWorkTools.loadData(URLString: "api/v1/getHotCate", params: hotCateParams) { (result) in
            
            guard let resultDict = result as? [String : Any] else { return }
            guard let dataArray = resultDict["data"] as? [[String : Any]] else { return }
            
            for dict in dataArray {
                let groupModel = BaseGroupRoomModel(dict: dict)
                
                if groupModel.tag_name == "颜值" { continue }
                
                self.groupData.append(groupModel)
                
            }
            
            GCDGroup.leave()
        }
        
        GCDGroup.notify(queue: DispatchQueue.main) {
            
            self.groupData.insert(self.verticalData, at: 0)
            self.groupData.insert(self.bigHotData, at: 0)
            
            finishedCallback()
        }
        
        
    }
    
}
