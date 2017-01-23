//
//  AmuseViewModel.swift
//  YuDou
//
//  Created by Bemagine on 2017/1/22.
//  Copyright © 2017年 bemagine. All rights reserved.
//

import UIKit

class AmuseViewModel : BaseViewModel {
    
    var identification: String?
}

extension AmuseViewModel {
    
    func loadAmuseData(finishedCallback: @escaping () -> ()) {
        
        let urlString = "api/homeCate/getHotRoom"
        let params = ["identification" : identification ?? "", "client_sys" : "ios"]
        
        NetWorkTools.loadData(URLString: urlString, params: params) { (reponse) in
            
            guard let resultDict = reponse as? [String : Any] else { return }
            guard let dataArray = resultDict["data"] as? [[String : Any]] else { return }
            
            for dict in dataArray {
                let groupModel = BaseGroupRoomModel(dict: dict)
                self.groupData.append(groupModel)
                
            }
            
            finishedCallback()
            
        }
        
        
    }
    
}
