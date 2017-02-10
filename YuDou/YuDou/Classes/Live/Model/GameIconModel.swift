//
//  GameIconModel.swift
//  YuDou
//
//  Created by Bemagine on 2017/2/8.
//  Copyright © 2017年 bemagine. All rights reserved.
//

import UIKit

class GameIconModel: NSObject {
    
    /*
     {
     "tag_id": "181",
     "short_name": "wzry",
     "tag_name": "\u738b\u8005\u8363\u8000",
     "pic_name": "b14b8890330ca7cb5185b954808485fc.jpg",
     "pic_name2": "3b1ae2d3fb371c4ebc487cb9936c6603.jpg",
     "icon_name": "f719087663581b7a723c4d39f8721bc1.jpg",
     "small_icon_name": "7f9e3b5077427438a3dd3cd3a3a93757.png",
     "orderdisplay": "2",
     "rank_score": "0",
     "night_rank_score": "0",
     "nums": "0",
     "push_ios": "1",
     "push_home": "1",
     "is_game_cate": "1",
     "cate_id": "9",
     "is_del": "0",
     "is_relate": "1",
     "push_vertical_screen": "0",
     "push_nearby": "0",
     "push_qqapp": "1",
     "broadcast_limit": "3",
     "vodd_cateids": "22",
     "open_full_screen": "0",
     "pic_url": "https:\/\/staticlive.douyucdn.cn\/upload\/game_cate\/b14b8890330ca7cb5185b954808485fc.jpg",
     "pic_url2": "https:\/\/staticlive.douyucdn.cn\/upload\/game_cate\/3b1ae2d3fb371c4ebc487cb9936c6603.jpg",
     "url": "\/directory\/game\/wzry",
     "icon_url": "https:\/\/staticlive.douyucdn.cn\/upload\/game_cate\/f719087663581b7a723c4d39f8721bc1.jpg",
     "small_icon_url": "https:\/\/staticlive.douyucdn.cn\/upload\/game_cate\/7f9e3b5077427438a3dd3cd3a3a93757.png",
     "count": "152",
     "count_ios": "70"
     }
     */
    
    var tag_id : String?
    var tag_name : String = ""
    var short_name : String?
    var pic_name : String?
    var icon_url : String?
    var small_icon_url : String?
    var url : String?
    var pic_url : String?
    /// 观看人数
    var nums : Int = 0
    

    init(dict: [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
