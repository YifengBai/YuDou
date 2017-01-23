//
//  CustomNavigationController.swift
//  YuDou
//
//  Created by Bemagine on 2017/1/17.
//  Copyright © 2017年 bemagine. All rights reserved.
//

import UIKit

class CustomNavigationController: UINavigationController {

    // load是只要类所在文件被引用就会被调用，而initialize是在类或者其子类的第一个方法被调用前调用。所以如果类没有被引用进项目，就不会有load调用；但即使类文件被引用进来，但是没有使用，那么initialize也不会被调用。
    override class func initialize() {
        
//        let navigationBar = UINavigationBar.appearance()
        
//        let backImage = UIImage.createImageWithColor(UIColor.orange)
//        
//        navigationBar.setBackgroundImage(backImage, for: .default)
        
//        navigationBar.barStyle = .black
//        navigationBar.barTintColor = ThemColor
        
         YFLog(message: "initialize")
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.barTintColor = ThemColor
        navigationBar.barStyle = .black
        
        // Do any additional setup after loading the view.
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)
    }

}
