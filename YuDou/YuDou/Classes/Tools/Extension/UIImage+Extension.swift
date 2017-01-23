//
//  UIImage+Extension.swift
//  YuDou
//
//  Created by Bemagine on 2017/1/17.
//  Copyright © 2017年 bemagine. All rights reserved.
//

import UIKit


extension UIImage {
    
    
    class func createImageWithColor(_ color: UIColor) -> UIImage {
        
        let rect = CGRect(x: CGFloat(0), y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size);
        let context = UIGraphicsGetCurrentContext();
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();
        return image!;
        
    }
    
}
