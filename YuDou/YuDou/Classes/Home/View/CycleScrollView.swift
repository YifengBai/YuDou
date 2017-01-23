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
            

            
            if slide.count > 1 {
//                // 将第一张添加到最后面
//                let imageView = UIImageView(frame: CGRect(x: self.frame.width * CGFloat(slide.count), y: 0, width: frame.width, height: frame.height))
//                let url = URL(string:  (slide.first?.pic_url)!)
//                imageView.kf.setImage(with: url, placeholder: UIImage(named: "Img_default"))
//                collectionView.addSubview(imageView)
//                
//                // 将最后一张添加到最前面
//                let imageView1 = UIImageView(frame: CGRect(x: -self.frame.width , y: 0, width: frame.width, height: frame.height))
//                let url1 = URL(string:  (slide.last?.pic_url)!)
//                imageView1.kf.setImage(with: url1, placeholder: UIImage(named: "Img_default"))
//                collectionView.addSubview(imageView1)
//                
//                collectionView.contentInset = UIEdgeInsetsMake(0, -self.frame.width, 0, self.frame.width)
//                collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: false)
//                pageControl.currentPage = 0
            }
            
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
        
//        if count > 1 {
//            return count + 2
//        }
        
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CycleViewCollectionId, for: indexPath)
        
        let data = slideArray?[indexPath.item]
        
//        if (slideArray?.count)! > 1 {
//            if indexPath.item == 0 {
//                data = slideArray?.last
//            } else if indexPath.item == (slideArray?.count)! + 1 {
//                data = slideArray?.first
//            } else {
//                data = slideArray?[indexPath.item - 1]
//            }
//        }
        
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
//        
//        // 2.计算pageControl的currentIndex
//        // 滚动到最后一张(既显示的是第一张)，就滚动到第一张
//        if offsetX > scrollView.bounds.width * CGFloat((slideArray?.count)!) + scrollView.bounds.width * 0.5 {
//            scrollView.setContentOffset(CGPoint(x:scrollView.bounds.width, y:0), animated: false)
//            pageControl.currentPage = 0
//            return
//        }
//        // 滚动到第一张(即显示的是最后一张)
//        if offsetX <= -scrollView.bounds.width * 0.5 {
//            scrollView.setContentOffset(CGPoint(x:scrollView.bounds.width * CGFloat((slideArray?.count)! - 1), y:0), animated: false)
//            pageControl.currentPage = (slideArray?.count)! - 1
//            return
//        }
        pageControl.currentPage = Int((offsetX) / scrollView.bounds.width)
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        
        YFLog(message: "滚动结束")
        
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
//        YFLog(message: "滚动结束s")
        
//        let offsetX = scrollView.contentOffset.x
//        
//        
//        // 计算pageControl的currentIndex
//        // 滚动到最后一张(既显示的是第一张)，就滚动到第一张
//        if offsetX > scrollView.bounds.width * CGFloat((slideArray?.count)!) + scrollView.bounds.width * 0.5 {
//            scrollView.setContentOffset(CGPoint(x:scrollView.bounds.width, y:0), animated: false)
//            pageControl.currentPage = 0
//            return
//        }
//        // 滚动到第一张(即显示的是最后一张)
//        if offsetX <= -scrollView.bounds.width * 0.5 {
//            scrollView.setContentOffset(CGPoint(x:scrollView.bounds.width * CGFloat((slideArray?.count)! - 1), y:0), animated: false)
//            pageControl.currentPage = (slideArray?.count)! - 1
//            return
//        }
        
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
