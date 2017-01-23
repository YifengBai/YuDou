//
//  BaseViewController.swift
//  YuDou
//
//  Created by Bemagine on 2017/1/16.
//  Copyright © 2017年 bemagine. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    var contentView : UIView?
    
    /// 加载动画
    fileprivate lazy var lodingView : UIImageView = { [unowned self] in
        
        let imageView = UIImageView(image: UIImage(named: "dyla_img_loading_1"))
        imageView.center = self.view.center
        imageView.animationImages = [UIImage(named: "dyla_img_loading_1")!,UIImage(named: "dyla_img_loading_2")!,UIImage(named: "dyla_img_loading_3")!,UIImage(named: "dyla_img_loading_4")!]
        imageView.animationDuration = 0.5
        imageView.animationRepeatCount = LONG_MAX
        imageView.autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin]
        imageView.isUserInteractionEnabled = false
        
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        
        setupUI()
        
    }
}

extension BaseViewController {
    
    func setupUI() {
        
        // 1.隐藏内容的View
        contentView?.isHidden = true
        
        // 2.添加执行动画的UIImageView
        view.addSubview(lodingView)
        
        // 3.给animImageView执行动画
        lodingView.startAnimating()
        
        // 4.设置view的背景颜色
        view.backgroundColor = UIColor(r: 250, g: 250, b: 250)
    }
    
    /// 加载成功完成
    func loadDataFinished() {
        // 1.停止动画
        lodingView.stopAnimating()
        
        // 2.隐藏animImageView
        lodingView.isHidden = true
        
        // 3.显示内容的View
        contentView?.isHidden = false
    }
    
    /// 加载失败
    func loadFiled() {

        // 停止动画
        lodingView.stopAnimating()

        // 设置图片为加载失败
        lodingView.image = UIImage(named: "dyla_img_loading_fail")
        
    }
}
