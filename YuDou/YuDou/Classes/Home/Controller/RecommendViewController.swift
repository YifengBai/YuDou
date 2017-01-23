//
//  RecommendViewController.swift
//  YuDou
//
//  Created by Bemagine on 2017/1/16.
//  Copyright © 2017年 bemagine. All rights reserved.
//

import UIKit

private let kCycleViewH = kScreenW * 3 / 8
private let kGameViewH : CGFloat = 60

class RecommendViewController: BaseAnchorViewController {
    
    fileprivate lazy var recommendVM: RecommendViewModel = RecommendViewModel()
    
    fileprivate lazy var cycleView : CycleScrollView = {
        let cycleView = CycleScrollView(frame: CGRect(x: 0, y: -(kCycleViewH + kGameViewH), width: kScreenW, height: kCycleViewH))
        return cycleView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

// MARK: - 重写父类方法
extension RecommendViewController {
    
    override func setupUI() {
        
        super.setupUI()
        
        collectionView.addSubview(cycleView)
        
        collectionView.contentInset = UIEdgeInsetsMake(kCycleViewH + kGameViewH, 0, kTabBarH, 0)
    }
    
    override func loadData() {
        
        baseVM = recommendVM
        
        recommendVM.loadRecommendData {
            
            
            self.collectionView.reloadData()
            
            YFLog(message: "加载结束")
            self.loadDataFinished()
        }
        
        recommendVM.loadSliDate { (success) in
            
            if success {
                self.cycleView.slideArray = self.recommendVM.slideData
            }
            
        }
        
    }
    
    
}


extension RecommendViewController : UICollectionViewDelegateFlowLayout {
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // 取出数据
        let groupD = self.recommendVM.groupData[indexPath.section]
        let item = groupD.anchors[indexPath.item]
        
        if  groupD.tag_name == "颜值" {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BeautyCellId, for: indexPath) as! BeautyCell
            
            cell.roomModel = item
            
            return cell
        } else {
            return super.collectionView(collectionView, cellForItemAt: indexPath)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 取出数据
        let groupD = self.baseVM.groupData[indexPath.section]
        
        if  groupD.tag_name == "颜值" {
            
            return CGSize(width: kNormalItemW, height: kPrettyItemH)
        }
        
        return CGSize(width: kNormalItemW, height: kNormalItemH)
    }
    
}
