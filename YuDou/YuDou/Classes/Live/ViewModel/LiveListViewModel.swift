//
//  LiveLiseViewModel.swift
//  YuDou
//
//  Created by Bemagine on 2017/2/8.
//  Copyright © 2017年 bemagine. All rights reserved.
//

import UIKit

class LiveListViewModel: BaseViewModel {
    
    lazy var listArray : [BaseRoomModel] = [BaseRoomModel]()
    
    lazy var gameAssembly : [GameIconModel] = [GameIconModel]()
    
    var isRefresh: Bool = false
}

extension LiveListViewModel {
    
    func loadLiveListData(tag_id: String?, finishedCallback: @escaping () -> ()) {
        
        var urlString = "api/v1/live?limit=20&client_sys=ios&offset=0"
        
        if let tagId = tag_id {
            urlString = "api/v1/live/\(tagId)?limit=20&client_sys=ios&offset=0"
        }
        
        NetWorkTools.loadData(URLString: urlString, params: nil) { (reponse) in
            
            guard let resultDict = reponse as? [String : Any] else { return }
            guard let dataArray = resultDict["data"] as? [[String : Any]] else { return }
            
            if self.isRefresh {
                self.listArray.removeAll()
            }
            
            for dict in dataArray {
                let roomModel = BaseRoomModel(dict: dict)
                self.listArray.append(roomModel)
            }
            
            finishedCallback()
            
        }
    }
    
    func loadLiveData(cateId: String?, finishedCallback: @escaping () -> ()) {
        
        
        var urlString = "api/v1/getColumnRoom/1?limit=20&client_sys=ios&offset=0"
        
        if let cate = cateId {
            urlString = "api/v1/getColumnRoom/\(cate)?limit=20&client_sys=ios&offset=0"
        }
        
        NetWorkTools.loadData(URLString: urlString, params: nil) { (reponse) in
            
            guard let resultDict = reponse as? [String : Any] else { return }
            guard let dataArray = resultDict["data"] as? [[String : Any]] else { return }
            
            if self.isRefresh {
                self.listArray.removeAll()
            }
            
            for dict in dataArray {
                let roomModel = BaseRoomModel(dict: dict)
                self.listArray.append(roomModel)
            }
            
            finishedCallback()
            
        }
    }
    
    
    func loadCategoryDetailData(shortName: String?, finishedCallback: @escaping () -> ()) {
        
        var urlString = "api/v1/getColumnDetail?client_sys=ios"
        if shortName != nil {
            urlString = "api/v1/getColumnDetail?shortName=\(shortName!)&client_sys=ios"
        }
        
        NetWorkTools.loadData(URLString: urlString, params: nil) { (reponse) in
            
            guard let resultDict = reponse as? [String : Any] else { return }
            guard let dataArray = resultDict["data"] as? [[String : Any]] else { return }
            
            
            if self.isRefresh {
                self.gameAssembly.removeAll()
            }
            
            for dict in dataArray {
                let gameModel = GameIconModel(dict: dict)
                self.gameAssembly.append(gameModel)
            }
            
            finishedCallback()
            
        }
    }
    
}
