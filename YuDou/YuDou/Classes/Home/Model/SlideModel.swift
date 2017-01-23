//
//  SlideModel.swift
//  YuDou
//
//  Created by Bemagine on 2017/1/23.
//  Copyright © 2017年 bemagine. All rights reserved.
//

import UIKit

class SlideModel: NSObject {
    /*
    id": 162851,
    "title": "\u6211\u7684\u4e16\u754c\u5efa\u7b51\u5c55\u793a",
    "pic_url": "https:\/\/staticlive.douyucdn.cn\/upload\/signs\/201701221448176407.jpg",
    "tv_pic_url": "https:\/\/staticlive.douyucdn.cn\/upload\/signs\/201701221448204121.jpg",
    "room": {
     */
    
    var slide_id : Int = 0
    
    var title : String = ""
    
    var pic_url : String = "img_default"
    
    var tv_pic_url : String = ""
    
    var room : BaseRoomModel?
    
    init(dict : [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "room" {
            guard let dict = value as? [String : Any] else { return }
            room = BaseRoomModel(dict: dict)
            return
        }
        super.setValue(value, forKey: key)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
