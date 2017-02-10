//
//  PageContentView.swift
//  YuDou
//
//  Created by Bemagine on 2017/1/16.
//  Copyright © 2017年 bemagine. All rights reserved.
//

import UIKit

protocol PageContentViewDelegate : class {
    func pageContentView(_ contentView : PageContentView, progress : CGFloat, sourceIndex : Int, targetIndex : Int)
}

private let PageCollectionCellId = "PageCollectionCellId"

class PageContentView: UIView {
    
    fileprivate var childControllers: [UIViewController]
    fileprivate weak var parentVC: UIViewController?
    fileprivate var startScrollX : CGFloat = 0
    weak var delegate : PageContentViewDelegate?
    
    fileprivate var isNeedNotifyDelegate : Bool = true
    
    fileprivate lazy var contentView : UICollectionView = { [weak self] in
    
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.white
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: PageCollectionCellId)
//        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        return collectionView
    }()
    
    init(frame: CGRect, childVCs: [UIViewController], parentViewContnroller: UIViewController?) {
        self.childControllers = childVCs
        self.parentVC = parentViewContnroller
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        
//        contentView.frame = self.bounds
//    }
    
}

// MARK: - 设置UI
extension PageContentView {
    
    fileprivate func setupUI() {
        
        for childVC in childControllers {
            parentVC?.addChildViewController(childVC)
        }
        
        contentView.frame = bounds
        addSubview(contentView)
        
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate
extension PageContentView : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childControllers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PageCollectionCellId, for: indexPath)
        
        for subv in cell.contentView.subviews {
            subv.removeFromSuperview()
        }
        
        let curentVC = childControllers[indexPath.item]
        curentVC.view.frame = cell.contentView.bounds
        
        cell.contentView.addSubview(curentVC.view)
        
        return cell
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        isNeedNotifyDelegate = true
        
        startScrollX = scrollView.contentOffset.x
        
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        
        if !isNeedNotifyDelegate { return }

        var progress : CGFloat = 0
        var sourceIndex : Int = 0
        var targetIndex : Int = 0
        // 判断是左滑还是右滑
        let currentScrollX = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        
        if currentScrollX > startScrollX { // 左滑
            
            progress = currentScrollX / scrollViewW - floor(currentScrollX / scrollViewW)
            
            sourceIndex = Int(currentScrollX / scrollViewW)
            targetIndex = sourceIndex + 1
            
            if targetIndex >= childControllers.count {
                targetIndex = childControllers.count - 1
            }
            // 如果完全划过去
            if currentScrollX - startScrollX == scrollViewW {
                progress = 1
                targetIndex = sourceIndex
            }
        } else { // 右滑
            // 计算progress
            progress = 1 - (currentScrollX / scrollViewW - floor(currentScrollX / scrollViewW))
            
            // 计算targetIndex
            targetIndex = Int(currentScrollX / scrollViewW)
            
            // 计算sourceIndex
            sourceIndex = targetIndex + 1
            if sourceIndex >= childControllers.count {
                sourceIndex = childControllers.count - 1
            }
        }
        
        // 将progress/sourceIndex/targetIndex传递给titleView
        delegate?.pageContentView(self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
        
    }
    
}

// MARK: - 对外暴露的方法
extension PageContentView {
    
    func setCurrentIndex(index curIndex: NSInteger) {
        
        // 不需要通知代理
        isNeedNotifyDelegate = false
        
        // 滚动正确的位置
        let offsetX = CGFloat(curIndex) * contentView.frame.width
        contentView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
        
    }
    
}
