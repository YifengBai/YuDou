//
//  LiveCommonViewController.swift
//  YuDou
//
//  Created by Bemagine on 2017/2/7.
//  Copyright © 2017年 bemagine. All rights reserved.
//

import UIKit

private let GameIconCellId = "GameIconCellId"

class LiveCommonViewController: BaseAnchorViewController {
    
    fileprivate lazy var commonVM : LiveListViewModel = LiveListViewModel()
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(UINib(nibName: "GameIconCell", bundle: nil), forCellWithReuseIdentifier: GameIconCellId)
        
    }

    
}

extension LiveCommonViewController {
    
    override func setupUI() {
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: (kScreenW) / 3, height: (kScreenW) / 3)
        layout.headerReferenceSize = CGSize.zero
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        
        collectionView.contentInset = UIEdgeInsetsMake(0, 0, kTabBarH, 0)
        
        super.setupUI()
        
    }
    
    override func loadData() {
        
        baseVM = commonVM
        
        commonVM.loadCategoryDetailData(shortName: nil) {
            
            self.loadDataFinished()
            
            self.collectionView.reloadData()
        }
    }
    
}

// MARK: - override super func
extension LiveCommonViewController {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return commonVM.gameAssembly.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GameIconCellId, for: indexPath) as! GameIconCell
        
        cell.gameModel = commonVM.gameAssembly[indexPath.item]
        
        cell.contentView.layer.borderWidth = 1;
        cell.contentView.layer.borderColor = UIColor(r: 240, g: 240, b: 240).cgColor
        
        return cell

    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        return UICollectionReusableView()
    }
    
}
