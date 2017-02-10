//
//  ScrollSegement.swift
//  YuDou
//
//  Created by Bemagine on 2017/2/7.
//  Copyright © 2017年 bemagine. All rights reserved.
//

import UIKit

private let TitleNorColor : (CGFloat, CGFloat, CGFloat) = (220.0, 220.0, 220.0)
private let TitleSelColor : (CGFloat, CGFloat, CGFloat) = (255.0, 255.0, 255.0)

class ScrollSegement: UIView {

    /// 标题数组
    var titles: [String]?
    
    /// 标题label数组
    fileprivate var titleLabels: [UILabel] = [UILabel]()
    /// 底部滚动线条
    fileprivate lazy var scrollLine : UIView = {
        let line = UIView(frame: CGRect.zero)
        line.backgroundColor = UIColor.white
        return line
    }()
    /// label父视图
    fileprivate lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: 40))
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.backgroundColor = UIColor.clear
        scrollView.bounces = false
        return scrollView
    }()
    
    // scrollView 的 contentSize 的宽度
    fileprivate var contenWidth : CGFloat = 0
    
    /// 当前选中的label
    var curSelectedIndex : Int = 0
    
    /// 传递当前选中的label的下标
    var selectedIndex: ((_ selectedIndex: Int) -> ())?
    
    init(frame: CGRect, titles: [String], norSelectedIndex: Int) {
        
        super.init(frame: frame)
        
        self.titles = titles
        
        self.curSelectedIndex = norSelectedIndex
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: - UI
extension ScrollSegement {
    
    /// 设置视图
    fileprivate func setupView() {
        
        for subView in subviews {
            subView.removeFromSuperview()
        }
        
        scrollView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        addSubview(scrollView)
        
        // 设置label
        setupLabels()
        
        // 设置底部滑动线条
        setupScrollLine()
        
    }
    
    private func setupLabels() {
        
        let labelH : CGFloat = frame.height
        let labelY : CGFloat = 0
        var labelX : CGFloat = 0
        for (index, title) in titles!.enumerated() {
            
            // 计算字符串的宽度，高度
            let font : UIFont = UIFont.systemFont(ofSize: 15)
            let attributes = [NSFontAttributeName:font]
            let option = NSStringDrawingOptions.usesLineFragmentOrigin
            let labelW : CGFloat = title.boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: labelH), options: option, attributes: attributes, context: nil).size.width + 20.0
            
            let label = UILabel(frame: CGRect(x: labelX, y: labelY, width: labelW, height: labelH))
            labelX = labelX + labelW
            label.text = title
            label.tag = index
            label.font = font
            label.textAlignment = .center
            // 默认选中第二个
            if index == curSelectedIndex {
                label.textColor = UIColor(r: TitleSelColor.0, g: TitleSelColor.1, b: TitleSelColor.2)
            } else {
                label.textColor = UIColor(r: TitleNorColor.0, g: TitleNorColor.1, b: TitleNorColor.2)
            }
            label.backgroundColor = UIColor.clear
            
            // 添加事件
            label.isUserInteractionEnabled = true
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.labelTapAction(tapGes:)))
            label.addGestureRecognizer(tapGesture)
            
            scrollView.addSubview(label)
            titleLabels.append(label)
            
        }
        // 设置scrollView的contenSize
        contenWidth = labelX
        scrollView.contentSize = CGSize(width: labelX, height: 0)
        
    }
    
    private func setupScrollLine() {
        let label = titleLabels[1]
        scrollLine.frame = CGRect(x: label.frame.origin.x + 5, y: frame.height - 2.0, width: label.frame.width - 10, height: 2.0)
        addSubview(scrollLine)
    }
    
}
// MARK: - Action
extension ScrollSegement {
    
    /// title label tap action
    @objc fileprivate func labelTapAction(tapGes : UITapGestureRecognizer) {
        
        guard let label = tapGes.view as? UILabel else { return }
    
        // 获取上一个选中的label
        let sourceLabel = titleLabels[curSelectedIndex]
        curSelectedIndex = label.tag
        
        // 更换label颜色
        sourceLabel.textColor = UIColor(r: TitleNorColor.0, g: TitleNorColor.1, b: TitleNorColor.2)
        label.textColor = UIColor(r: TitleSelColor.0, g: TitleSelColor.1, b: TitleSelColor.2)
        
        titleLabelTransform(sourceLabel: sourceLabel, targetLabel: label)
        
        // 闭包传值
        guard let selectedIndex = selectedIndex else { return }
        selectedIndex(curSelectedIndex)
        
    }
}
// MARK: - 内部方法
extension ScrollSegement {
    
    /// 设置title label的变换
    fileprivate func titleLabelTransform(sourceLabel: UILabel, targetLabel label: UILabel) {
        
        let x = getScrollViewBoundsWith(label: label)
        
        // scrollView的contentOffSet
        scrollView.setContentOffset(CGPoint(x: x.scrollViewX, y: 0), animated: true)
        
        // 设置scrollLine的位置
        UIView.animate(withDuration: 0.5, animations: {
            self.scrollLine.frame = CGRect(x: x.scrollLineX + 5, y: self.scrollLine.frame.origin.y, width: label.frame.width - 10, height: self.scrollLine.frame.height)
        })
        
    }
    
    
    /// 根据label计算scrollView当前的bounds的x以及当前scrollLine的frame的x
    fileprivate func getScrollViewBoundsWith(label: UILabel) -> (scrollViewX: CGFloat, scrollLineX: CGFloat) {
        
        let labelX = label.frame.origin.x
        let labelV = label.frame.width * 0.5
        
        if labelX + label.frame.width * 0.5 > frame.width * 0.5 && contenWidth - label.frame.origin.x - label.frame.size.width * 0.5 > frame.width * 0.5 {
            // 此时label在中间
            return (labelX + labelV - frame.width * 0.5, frame.width * 0.5 - labelV)
            
        } else if labelX + labelV <= frame.width * 0.5 {
            // 此时scrollView在最左边
            return (0, label.frame.origin.x)
            
        } else if contenWidth - labelX - labelV <=  frame.width * 0.5 {
            // 此时scrollView在最右边
            return (contenWidth - frame.width, frame.width - (contenWidth - labelX))
        }

        return (0, 0)
    }
    
}
// MARK: - 外部方法
extension ScrollSegement {
    
    func setTitleLabelWithProgress(_ progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        
        // 跟新当前选中下标
        curSelectedIndex = targetIndex
        
        // 取出当前label及目标label
        let sourceLabel = titleLabels[sourceIndex]
        let targetLabel = titleLabels[targetIndex]
    
        let sourceLabelW = sourceLabel.frame.width
        let targetLabelW = targetLabel.frame.width
        
        // 源label时scrollView的bounds的x及scrollLine的x
        let sourceX = getScrollViewBoundsWith(label: sourceLabel)
        // 目标label的scrollView的bounds的x及scrollLine的x
        let targetX = getScrollViewBoundsWith(label: targetLabel)
        
        // scrollView位置变换
        let progressX = sourceX.scrollViewX + (targetX.scrollViewX - sourceX.scrollViewX) * progress
        scrollView.contentOffset = CGPoint(x: progressX, y: 0)
        
        // scrollLine的frame的x
        let targetLineX = (targetX.scrollLineX - sourceX.scrollLineX) * progress + sourceX.scrollLineX
        // scrollLine的宽度
        let targetLineW = (targetLabelW - sourceLabelW) * progress + sourceLabelW - 10
        // 设置scrollLine的位置
        self.scrollLine.frame = CGRect(x: targetLineX + 5 * progress, y: self.scrollLine.frame.origin.y, width: targetLineW, height: self.scrollLine.frame.height)
        
        
        // label颜色变换
        sourceLabel.textColor = UIColor(r: (TitleNorColor.0 - TitleSelColor.0) * progress + TitleSelColor.0, g: (TitleNorColor.1 - TitleSelColor.1) * progress + TitleSelColor.1, b: (TitleNorColor.2 - TitleSelColor.2) * progress + TitleSelColor.2)
        targetLabel.textColor = UIColor(r: TitleNorColor.0 - (TitleNorColor.0 - TitleSelColor.0) * progress , g: TitleNorColor.1 - (TitleNorColor.1 - TitleSelColor.1) * progress, b: TitleNorColor.2 - (TitleNorColor.2 - TitleSelColor.2) * progress)
    }
    
    
}

