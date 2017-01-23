//
//  BaseRoomModel.swift
//  YuDou
//
//  Created by Bemagine on 2017/1/20.
//  Copyright © 2017年 bemagine. All rights reserved.
//

import UIKit

class BaseRoomModel: NSObject {
    /*
    specific_catalog": "longeJJC",
    "vertical_src": "https:\/\/rpic.douyucdn.cn\/a1701\/20\/15\/895416_170120152520.jpg",
    "ranktype": "51",
    "nickname": "emdrogen",
    "subject": "",
    "room_src": "https:\/\/rpic.douyucdn.cn\/a1701\/20\/15\/895416_170120152520.jpg",
    "rpos": "10",
    "cate_id": "2",
    "specific_status": "0",
    "game_name": "\u7089\u77f3\u4f20\u8bf4",
    "push_ios": "1",
    "avatar_small": "https:\/\/apic.douyucdn.cn\/upload\/avatar\/default\/08_small.jpg",
    "online": 1295,
    "recomType": "1",
    "avatar_mid": "https:\/\/apic.douyucdn.cn\/upload\/avatar\/default\/08_middle.jpg",
    "vod_quality": "0",
    "child_id": "155",
    "room_name": "\u9f99\u683c\uff1a\u7ade\u6280\u573a1w9+\u603b\u80dc\u573a\uff0c\u795e\u7ea7\u5f00\u5149\u5634",
    "room_id": "895416",
    "isVertical": 0,
    "show_time": "1484871137",
    "show_status": "1",
    "jumpUrl": ""
 */
    
    var specific_catalog : String?
    /// 游戏名称
    var game_name : String = ""
    /// 房间名称
    var room_name : String = ""
    /// 房间id
    var room_id : String = ""
    var room_src : String?
    /// 房间图片对应的URLString
    var vertical_src : String = ""
    var avatar_small: String?
    var avatar_mid : String?
    
    /// 主播昵称
    var nickname : String = ""
    /// 在线人数
    var online : Int = 0
    /// 0 : 电脑直播(普通房间) 1 : 手机直播(秀场房间)
    var isVertical : Int = 0
    /// 直播城市
    var anchor_city : String = ""
    
    init(dict: [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
    

}
