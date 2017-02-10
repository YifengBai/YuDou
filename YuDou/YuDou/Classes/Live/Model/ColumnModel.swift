//
//  ColumnModel.swift
//  YuDou
//
//  Created by Bemagine on 2017/2/7.
//  Copyright © 2017年 bemagine. All rights reserved.
//

import UIKit

class ColumnModel: NSObject {
    
    /*
     "cate_id": "1",
     "cate_name": "\u70ed\u95e8\u6e38\u620f",
     "short_name": "game",
     "push_ios": "1",
     "push_show": "0",
     "push_vertical_screen": "0",
     "push_nearby": "0"
     */
    
    var cate_id : String?
    var cate_name : String?
    var short_name : String?
    var push_ios : String?
    var push_show : String?
    var push_vertical_screen : String?
    var push_nearby : String?

    init(dict: [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
