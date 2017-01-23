//
//  BaseGroupRoomModel.swift
//  YuDou
//
//  Created by Bemagine on 2017/1/20.
//  Copyright © 2017年 bemagine. All rights reserved.
//

import UIKit

class BaseGroupRoomModel: NSObject {
    /*
    "push_vertical_screen": "0",
    "icon_url": "https:\/\/staticlive.douyucdn.cn\/upload\/game_cate\/d3e0073bfb714186ab0c818744601963.jpg",
    "tag_name": "\u82f1\u96c4\u8054\u76df",
    "push_nearby": "0",
    "tag_id": "1"
     */
    
    /// 该组中对应的房间信息
    var room_list : [[String : NSObject]]? {
        didSet {
            guard let room_list = room_list else { return }
            for dict in room_list {
                anchors.append(BaseRoomModel(dict: dict))
            }
        }
    }
    var tag_name : String = ""
    var icon_url : String? = ""
    var small_icon_url : String? = ""
    var tag_id : String?
    var count : Int = 0
    var count_ios : Int = 0
    /// 组显示的图标
    var icon_name : String = "home_header_normal"
    /// 定义主播的模型对象数组
    lazy var anchors : [BaseRoomModel] = [BaseRoomModel]()
    
    var push_vertical_screen : Int = 0
    var push_nearby : String?
    
    override init() {
        super.init()
    }
    
    init(dict : [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "count" {
            return
        }
        if key == "count_ios" {
            return
        }
        super.setValue(value, forKey: key)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }

}
