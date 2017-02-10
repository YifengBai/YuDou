//
//  CycleScrollView.swift
//  YuDou
//
//  Created by Bemagine on 2017/1/23.
//  Copyright © 2017年 bemagine. All rights reserved.
//

import UIKit

private let CycleViewCollectionId = "CycleViewCollectionId"

class CycleScrollView: UIView {
    
    var timer : Timer?

    fileprivate lazy var collectionView : UICollectionView = { [weak self] in
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        let colleV = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        colleV.backgroundColor = ThemColor
        colleV.delegate = self
        colleV.dataSource = self
        colleV.isPagingEnabled = true
        colleV.register(UICollectionViewCell.self, forCellWithReuseIdentifier: CycleViewCollectionId)
        colleV.showsVerticalScrollIndicator = false
        colleV.showsHorizontalScrollIndicator = false
        return colleV
    }()
    
    fileprivate lazy var pageControl : UIPageControl = { [weak self] in
        let pageControl = UIPageControl(frame: CGRect.zero)
        pageControl.currentPageIndicatorTintColor = ThemColor
        pageControl.pageIndicatorTintColor = UIColor(r: 240, g: 240, b: 240)
        pageControl.contentHorizontalAlignment = .center
        
        return pageControl
    }()
    
    
    var slideArray : [SlideModel]? {
        didSet {
            guard let slide = slideArray else { return }
            
            collectionView.reloadData()
            
            pageControl.numberOfPages = slide.count
            
            let indexPath = IndexPath(item: slide.count * 200, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .left, animated: false)

            removeCycleTimer()
            addCycleTimer()
            
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.collectionView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        (self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout).itemSize = frame.size
        self.pageControl.frame = CGRect(x: 0, y: frame.height-20, width: frame.width, height: 20)
        self.addSubview(self.collectionView)
        self.addSubview(self.pageControl)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}

extension CycleScrollView : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let count = slideArray?.count else {
            return 0
        }
        
        return count * 10000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CycleViewCollectionId, for: indexPath)
        
        let data = slideArray?[indexPath.item % slideArray!.count]
        
        for subv in cell.contentView.subviews {
            subv.removeFromSuperview()
        }
        
        let imageView = UIImageView(frame: cell.contentView.bounds)
        let url = URL(string:  (data?.pic_url)!)
        imageView.kf.setImage(with: url, placeholder: UIImage(named: "Img_default"))
        
        cell.contentView.addSubview(imageView)
        return cell
    }
}
extension CycleScrollView : UICollectionViewDelegate {
    
    
}

extension CycleScrollView {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        // 1.获取滚动的偏移量
        let offsetX = scrollView.contentOffset.x + scrollView.bounds.width * 0.5
       
        pageControl.currentPage = Int((offsetX) / scrollView.bounds.width) % slideArray!.count
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        
        
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeCycleTimer()
        
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        addCycleTimer()
    }

}

// MARK: - 对定时器的操作方法
extension CycleScrollView {
    
    fileprivate func addCycleTimer() {
        
        timer = Timer(timeInterval: 3.0, target: self, selector: #selector(self.scrollToNext), userInfo: nil, repeats: true)
        
        RunLoop.main.add(timer!, forMode: .commonModes)
    }
    
    fileprivate func removeCycleTimer () {
        timer?.invalidate() // 从运行循环中移除
        timer = nil
    }
    
    @objc fileprivate func scrollToNext() {
        
        // 1.获取滚动的偏移量
        let currentOffsetX = collectionView.contentOffset.x
        let offsetX = currentOffsetX + collectionView.bounds.width
        
        // 2.滚动该位置
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
        
    }
    
}
