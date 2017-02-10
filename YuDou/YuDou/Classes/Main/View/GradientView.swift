//
//  GradientView.swift
//  YuDou
//
//  Created by Bemagine on 2017/2/10.
//  Copyright © 2017年 bemagine. All rights reserved.
//

import UIKit

class GradientView: UIView {

    fileprivate var startRGBColor: UIColor = UIColor(red: CGFloat(200.0/255.0), green: CGFloat(200.0/255.0), blue: CGFloat(200.0/255.0), alpha: 0)
    
    fileprivate var endRGBColor: UIColor = UIColor(r: 200, g: 200, b: 200)
    
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        
        // 1.获取图形上下文
        guard let currentContext = UIGraphicsGetCurrentContext() else { return }
        
        // 2.图形上下文将被存储，以便于之后的存储操作
        currentContext.saveGState()
        
        // 3.CGColorSpace 描述的是颜色的域值范围。大多情况下你会使用到 RGB 模式来描述颜色。
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        // 4.这里我们定义一个渐变样式的起始颜色和结束颜色。CGColor 对象是底层颜色接口的定义。这个接口方法会从 CGColor 中获取指定颜色。
        let startColor = startRGBColor
        guard let startColorComponents = startColor.cgColor.components else { return }
        
        let endColor = endRGBColor
        guard let endColorComponents = endColor.cgColor.components else { return }
        
        // 5.在这个数组中，将 RGB 颜色分量和 alpha 值写入。
        let colorComponents: [CGFloat] = [startColorComponents[0], startColorComponents[1], startColorComponents[2], startColorComponents[3], endColorComponents[0], endColorComponents[1], endColorComponents[2], endColorComponents[3]]
        
        // 6.在此处可以定义各种颜色的相对位置。
        let locations: [CGFloat] = [0.0, 1.0]
        
        // 7.CGGradient 用来描述渐变信息。
        guard let gradient = CGGradient(colorSpace: colorSpace, colorComponents: colorComponents, locations: locations, count: 2) else { return }
        
        let startPoint = CGPoint(x: 0, y: self.bounds.height)
        let endPoint = CGPoint(x: self.bounds.width, y: self.bounds.height)
        
        // 8.这里渐变将沿纵轴 (vertical axis) 方向绘制。
        currentContext.drawLinearGradient(gradient, start: startPoint, end: endPoint, options: CGGradientDrawingOptions(rawValue: UInt32(0)))
        
        // 9存储图形上下文。
        currentContext.restoreGState()
        
    }
    
    func drawGradientColorViewWith(startColor: UIColor, endColor: UIColor) {
        
        
        self.startRGBColor = startColor
        
        self.endRGBColor = endColor
        
        self.setNeedsDisplay()
        
    }
 

}
