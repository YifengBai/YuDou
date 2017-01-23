//
//  MainViewController.swift
//  YuDou
//
//  Created by Bemagine on 2017/1/4.
//  Copyright © 2017年 bemagine. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        addChildVc("Home")
        addChildVc("Live")
        addChildVc("Follow")
        addChildVc("Find")
        addChildVc("Profile")
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func addChildVc(_ storyBoardName: String) {
        
        let childVc = UIStoryboard(name: storyBoardName, bundle: nil).instantiateInitialViewController()!
        
        addChildViewController(childVc)
    }


}
