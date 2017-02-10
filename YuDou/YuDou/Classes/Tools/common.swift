//
//  common.swift
//  YuDou
//
//  Created by Bemagine on 2017/1/16.
//  Copyright © 2017年 bemagine. All rights reserved.
//

import UIKit

let kStatusBarH : CGFloat = 20
let kNavitagionBarH : CGFloat = 44
let kTabBarH : CGFloat = 49

let kScreenH = UIScreen.main.bounds.height
let kScreenW = UIScreen.main.bounds.width

let ThemColor = UIColor.orange

// MARK: - 通知中心
let NotificationNavigationBarTransform = "NavigationBarTransform"



// MARK: - common func

infix operator ???: NilCoalescingPrecedence

public func ???<T>(optional: T?, defaultValue: @autoclosure () -> String) -> String {
    
    return optional.map { String(describing: $0) } ?? defaultValue()
}
