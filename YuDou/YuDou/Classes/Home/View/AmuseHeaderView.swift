//
//  AmuseHeaderView.swift
//  YuDou
//
//  Created by Bemagine on 2017/1/23.
//  Copyright © 2017年 bemagine. All rights reserved.
//

import UIKit

private let AmuseHeaderCellId = "AmuseHeaderCellId"

class AmuseHeaderView: UIView {
    
    var amuseArray : [BaseGroupRoomModel]? {
        didSet{
            collectionView.reloadData()
        }
    }
   
    fileprivate lazy var collectionView : UICollectionView = { [weak self] in
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: kScreenW / 4, height: kScreenW / 4 + 10)
        
        let colleV = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        colleV.backgroundColor = UIColor.white
        colleV.delegate = self
        colleV.dataSource = self
        colleV.isPagingEnabled = true
        colleV.register(AmuseGameCell.self, forCellWithReuseIdentifier: AmuseHeaderCellId)
        colleV.showsHorizontalScrollIndicator = false
        return colleV
        }()
    
    fileprivate lazy var pageControl : UIPageControl = { [weak self] in
        let pageControl = UIPageControl(frame: CGRect.zero)
        pageControl.currentPageIndicatorTintColor = ThemColor
        pageControl.pageIndicatorTintColor = UIColor(r: 240, g: 240, b: 240)
        pageControl.contentHorizontalAlignment = .center
        pageControl.numberOfPages = 2
        pageControl.currentPage = 1
        return pageControl
        }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        collectionView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        addSubview(collectionView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

extension AmuseHeaderView : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let count = amuseArray?.count else {
            return 0
        }
        
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AmuseHeaderCellId, for: indexPath) as! AmuseGameCell
        
        let data = amuseArray?[indexPath.item]
        
        cell.gameModel = data
        
        return cell
    }
}

extension AmuseHeaderView : UICollectionViewDelegate {
    
}
