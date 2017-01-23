//
//  BaseAnchorViewController.swift
//  YuDou
//
//  Created by Bemagine on 2017/1/16.
//  Copyright © 2017年 bemagine. All rights reserved.
//

import UIKit

private let kItemMargin : CGFloat = 10
private let kHeaderViewH : CGFloat = 50

let kNormalItemW = (kScreenW - 3 * kItemMargin) / 2
let kNormalItemH = kNormalItemW * 3 / 4
let kPrettyItemH = kNormalItemW * 4 / 3

private let HeaderViewId = "collectionSectionHeaderId"
private let GameCellId = "GameCellId"
let BeautyCellId = "BeautyCellId"

class BaseAnchorViewController: BaseViewController {
    
    var baseVM : BaseViewModel!
    
    lazy var collectionView : UICollectionView = {[unowned self] in
    
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        layout.itemSize = CGSize(width: kNormalItemW, height: kNormalItemH)
        layout.sectionInset = UIEdgeInsetsMake(0, kItemMargin, 0, kItemMargin)
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.backgroundColor = UIColor.white
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: "GameCell", bundle: nil), forCellWithReuseIdentifier: GameCellId)
        collectionView.register(UINib(nibName: "BeautyCell", bundle: nil), forCellWithReuseIdentifier: BeautyCellId)
        collectionView.register(UINib(nibName: "SectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: HeaderViewId)
        
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        loadData()
    }
    
    
}

extension BaseAnchorViewController {
    override func setupUI() {
        
        contentView = collectionView
        
        view.addSubview(collectionView)
        
        super.setupUI()
        
    }
    
    func loadData() {
        
    }
}

extension BaseAnchorViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
     
        return baseVM.groupData.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return baseVM.groupData[section].anchors.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // 取出数据
        let groupD = self.baseVM.groupData[indexPath.section]
        let item = groupD.anchors[indexPath.item]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GameCellId, for: indexPath) as! GameCell
        
        cell.roomModel = item
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: HeaderViewId, for: indexPath) as! SectionHeaderView
        
        header.group = baseVM.groupData[indexPath.section]
        
        return header
        
    }
}

