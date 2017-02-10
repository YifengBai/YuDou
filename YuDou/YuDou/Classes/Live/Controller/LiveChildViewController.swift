//
//  LiveChildViewController.swift
//  YuDou
//
//  Created by Bemagine on 2017/2/7.
//  Copyright © 2017年 bemagine. All rights reserved.
//

import UIKit

private let kHeaderViewHeight : CGFloat = 40

class LiveChildViewController: BaseAnchorViewController {
    
    var shortName: String?
    
    var columnModel : ColumnModel!
    
    fileprivate lazy var liveChildVM : LiveListViewModel = LiveListViewModel()
    
    fileprivate lazy var headerView : LiveHeaderCategoryView = {
    
        let headerView = LiveHeaderCategoryView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: kHeaderViewHeight))
        
        headerView.backgroundColor = UIColor.white
        
        headerView.delegate = self
        
        return headerView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

    }

}

extension LiveChildViewController {
    
    override func setupUI() {
        
        super.setupUI()
        
        view.addSubview(headerView)
        
        contentView?.frame = CGRect(x: 0.0, y: kHeaderViewHeight, width: kScreenW, height: (contentView?.frame.height)! - kStatusBarH)
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.headerReferenceSize = CGSize(width: 0, height: 0)
        layout.sectionInset = UIEdgeInsetsMake(kItemMargin, kItemMargin, 0, kItemMargin)
        collectionView.contentInset = UIEdgeInsetsMake(0, 0, kTabBarH, 0)
        
        
        
    }
    
    override func loadData() {
        
        baseVM = liveChildVM
        
        guard let shortName = shortName else {
            self.loadFiled()
            return
        }
        
        liveChildVM.isRefresh = true
        
        liveChildVM.loadCategoryDetailData(shortName: shortName) {
            
            let dict = ["tag_name" : "全部"]
            
            let allModel: GameIconModel = GameIconModel(dict: dict)
            
            var data = self.liveChildVM.gameAssembly
            
            data.insert(allModel, at: 0)
            
            self.headerView.itemArray = data
           
        }
        
        liveChildVM.loadLiveData(cateId: columnModel.cate_id, finishedCallback: {
            self.loadDataFinished()
            
            self.collectionView.reloadData()
            
        })
        
    }
}

extension LiveChildViewController {
    
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return liveChildVM.listArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let item = liveChildVM.listArray[indexPath.item]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GameCellId, for: indexPath) as! GameCell
        
        cell.roomModel = item
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        return UICollectionReusableView()
    }

    
    
}

extension LiveChildViewController: LiveHeaderCategoryViewDelegate {
    
    func headerCategoryBtnClick(headerView: LiveHeaderCategoryView, tagId: String?) {
        
        liveChildVM.isRefresh = true
        
        if tagId == nil {
            liveChildVM.loadLiveData(cateId: columnModel.cate_id, finishedCallback: { 
                self.collectionView.reloadData()
            })
        } else {
            liveChildVM.loadLiveListData(tag_id: tagId) {
                self.collectionView.reloadData()
            }
            
        }
        
    
    }
    
}
