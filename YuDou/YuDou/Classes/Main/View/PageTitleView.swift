//
//  PageTitleView.swift
//  YuDou
//
//  Created by Bemagine on 2017/1/4.
//  Copyright © 2017年 bemagine. All rights reserved.
//

import UIKit


protocol PageTitleViewDelegate : class{
    
    func pageTitleView(_ titleView: PageTitleView, selectedIndex index: Int)
    
}

// MARK: - 定义常量
private let kScrollLineH : CGFloat = 2
private let kNormalColor : (CGFloat, CGFloat, CGFloat) = (85, 85, 85)
private let kSelectColor : (CGFloat, CGFloat, CGFloat) = (255, 128, 0)

class PageTitleView: UIView {

    /// 标题数组
    fileprivate var titles: [String]!
    fileprivate lazy var titleLables : [UILabel] = [UILabel]()
    /// scrollView
    fileprivate lazy var scrollView : UIScrollView = {
        let sv = UIScrollView()
        sv.showsHorizontalScrollIndicator = false
        sv.scrollsToTop = false
        sv.bounces = false
        return sv
    }()
    /// 滚动指示条
    fileprivate lazy var scrollLine : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.orange
        return view
        
    }()
    
    /// 当前点击的index
    var curSelectedIndex : Int = 0
    /// 代理
    weak var delegate : PageTitleViewDelegate?
    
    init(frame: CGRect, titles: [String]) {
        
        self.titles = titles
        
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
// MARK: - 设置UI
extension PageTitleView {
    
    // 设置UI
    fileprivate func setupUI() {
        
        // 添加
        addSubview(scrollView)
        scrollView.frame = bounds
        
        // 添加title对应的label
        addTitleLabels()
        
        // 添加line
        addScrollLine()
        
    }
    
    /// 添加labels
    private func addTitleLabels() {
        
        let labelW : CGFloat = frame.width / CGFloat(titles.count)
        let labelH : CGFloat = frame.height
        let labelY : CGFloat = 0
        
        for (index, title) in titles.enumerated() {
            
            let labelX = CGFloat(index) * labelW
            let label = UILabel(frame: CGRect(x: labelX, y: labelY, width: labelW, height: labelH))
            
            label.text = title
            label.tag = index
            label.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
            label.textAlignment = .center
            
            scrollView.addSubview(label)
            titleLables.append(label)
            
            // 添加事件
            label.isUserInteractionEnabled = true
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.titleClickAction(_:)))
            label.addGestureRecognizer(tapGesture)
        }
        
        
    }
    
    /// 添加底部滚动线
    private func addScrollLine() {
        
        guard let label = titleLables.first else {
            return
        }
        
        label.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        
        scrollLine.frame = CGRect(x: label.frame.origin.x + label.frame.width * 0.1, y: frame.height - kScrollLineH, width: label.frame.width * 0.8, height: kScrollLineH)
        
        scrollView.addSubview(scrollLine)
    }
}

// MARK: - 事件方法
extension PageTitleView {
    
    /// label的点击事件
    @objc fileprivate func titleClickAction(_ tapGes : UITapGestureRecognizer) {
        
        // 获取当前label
        guard let curLabel = tapGes.view as? UILabel else { return }
        
        // 如果是点击同一个label，直接返回
        if curLabel.tag == curSelectedIndex { return }
        
        // 获取之前的label
        let previousLabel = titleLables[curSelectedIndex]
        
        // 切换文字颜色
        previousLabel.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
        curLabel.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        
        // 保存新的curSelextedIndex
        curSelectedIndex = curLabel.tag
        
        // 改变scrollLine位置
        UIView.animate(withDuration: 0.3) {
            self.scrollLine.frame.origin.x = curLabel.frame.origin.x + curLabel.frame.width * 0.1
        }
        
        // 通知代理
        delegate?.pageTitleView(self, selectedIndex: curSelectedIndex)
        
        
    }
    
}

// MARK: - 对外暴露的方法
extension PageTitleView {
    
    func setTitleWithProgress(_ progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        
        // 1.取出当前label及目标label
        let sourceLabel = titleLables[sourceIndex]
        let targetLabel = titleLables[targetIndex]
        
        
        // 2.处理滑块的逻辑
        let moveTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveX = moveTotalX * progress
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + moveX + sourceLabel.frame.width * 0.1
        
        // 3.颜色的渐变(复杂)
        // 3.1.取出变化的范围
        let colorDelta = (kSelectColor.0 - kNormalColor.0, kSelectColor.1 - kNormalColor.1, kSelectColor.2 - kNormalColor.2)
        
        // 3.2.变化sourceLabel
        sourceLabel.textColor = UIColor(r: kSelectColor.0 - colorDelta.0 * progress, g: kSelectColor.1 - colorDelta.1 * progress, b: kSelectColor.2 - colorDelta.2 * progress)
        
        // 3.2.变化targetLabel
        targetLabel.textColor = UIColor(r: kNormalColor.0 + colorDelta.0 * progress, g: kNormalColor.1 + colorDelta.1 * progress, b: kNormalColor.2 + colorDelta.2 * progress)
        
        // 4.记录最新的index
        curSelectedIndex = targetIndex

    }
}

