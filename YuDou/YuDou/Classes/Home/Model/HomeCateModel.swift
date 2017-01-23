//
//  HomeCateModel.swift
//  YuDou
//
//  Created by Bemagine on 2017/1/22.
//  Copyright © 2017年 bemagine. All rights reserved.
//

import UIKit

class HomeCateModel: NSObject {
    
    /*
     title": "\u624b\u6e38",
     "show_order": "1",
     "identification": "3e760da75be261a588c74c4830632360",
     "is_video": 0
     */
    
    var title : String = ""
    var show_order : String = ""
    var identification : String = ""
    var is_video : Int = 0
    
    init(dict : [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
