//
//  HomeViewController.swift
//  YuDou
//
//  Created by Bemagine on 2017/1/4.
//  Copyright © 2017年 bemagine. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
}

extension HomeViewController {
    
    private func setupUI() {
        
    }
    
    private func setupNavigationItem() {
        
        // 设置左边的Item
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName:"logo")
        
        // 设置右边的Item
        let size = CGSize(width: 40, height: 40);
        let historyItem = UIBarButtonItem(imageName: "image_my_history", highImageName: "Image_my_history_click", size: size)
        let searchItem = UIBarButtonItem(imageName: "btn_search", highImageName: "btn_search_clicked", size: size)
        let qrcodeItem = UIBarButtonItem(imageName: "Image_scan", highImageName: "Image_scan_click", size: size)
        navigationItem.rightBarButtonItems = [historyItem, searchItem, qrcodeItem]
        
        
        
    }
    
}
