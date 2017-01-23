//
//  AmuseViewController.swift
//  YuDou
//
//  Created by Bemagine on 2017/1/16.
//  Copyright © 2017年 bemagine. All rights reserved.
//

import UIKit

class AmuseViewController: BaseAnchorViewController {
    
    fileprivate lazy var amuseVM : AmuseViewModel = AmuseViewModel()
    
    fileprivate lazy var headerView : AmuseHeaderView = {
        
        let amuseView = AmuseHeaderView(frame: CGRect(x: 0, y: -((kScreenW / 4 + 20.0) * 2.0), width: kScreenW, height: (kScreenW / 4 + 10.0) * 2))
        
        return amuseView
    }()
    
    var cateModel : HomeCateModel? {
        didSet {
            guard let cateData = cateModel else { return }
            
            self.amuseVM.identification = cateData.identification
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}

extension AmuseViewController {
    
    
    override func loadData() {
        
        baseVM = amuseVM
        
        amuseVM.loadAmuseData {
            
            self.collectionView.reloadData()
            
            self.headerView.amuseArray = self.amuseVM.groupData
            
            self.loadDataFinished()
        }
    }
    
    override func setupUI() {
    
        super.setupUI()
        
        collectionView.addSubview(headerView)
        
        collectionView.contentInset = UIEdgeInsetsMake((kScreenW / 4 + 20.0) * 2, 0, kTabBarH, 0)
    }
    
}
