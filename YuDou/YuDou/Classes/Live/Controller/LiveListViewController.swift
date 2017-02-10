//
//  LiveListViewController.swift
//  YuDou
//
//  Created by Bemagine on 2017/2/8.
//  Copyright © 2017年 bemagine. All rights reserved.
//

import UIKit

class LiveListViewController: BaseAnchorViewController {
    
    fileprivate lazy var liveListVM : LiveListViewModel = LiveListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

    }

}

extension LiveListViewController {
    
    override func setupUI() {
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.headerReferenceSize = CGSize(width: 0, height: 0)
        layout.sectionInset = UIEdgeInsetsMake(kItemMargin, kItemMargin, 0, kItemMargin)
        collectionView.contentInset = UIEdgeInsetsMake(0, 0, kTabBarH, 0)
        
        super.setupUI()
        
    }
    
    override func loadData() {
        
        baseVM = liveListVM
        
        liveListVM.loadLiveListData(tag_id: nil, finishedCallback: {
            
            self.loadDataFinished()
            
            self.collectionView.reloadData()
            
        })
        
    }
    
}

extension LiveListViewController {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return liveListVM.listArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let item = liveListVM.listArray[indexPath.item]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GameCellId, for: indexPath) as! GameCell
        
        cell.roomModel = item
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        return UICollectionReusableView()
    }
    
}
