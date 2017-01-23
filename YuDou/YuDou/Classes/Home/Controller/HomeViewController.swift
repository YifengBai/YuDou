//
//  HomeViewController.swift
//  YuDou
//
//  Created by Bemagine on 2017/1/4.
//  Copyright © 2017年 bemagine. All rights reserved.
//

import UIKit

private let kTitleH : CGFloat = 40

class HomeViewController: BaseViewController {
    
    fileprivate lazy var homeCateArray : [HomeCateModel] = [HomeCateModel]()
    
    fileprivate var pageTitleView : PageTitleView!
    /*
    fileprivate lazy var pageTitleView : PageTitleView = {[weak self] in

        let titleFrame = CGRect(x: 0, y: kNavitagionBarH+kStatusBarH, width: kScreenW, height: kTitleH)
//        let pageTitleView = PageTitleView(frame: titleFrame, titles: ["推荐", "手游", "娱乐","游戏", "趣玩"])
        let pageTitleView = PageTitleView(frame: titleFrame, titles: ["推荐"])
        pageTitleView.delegate = self
        return pageTitleView
    }()
 */
    fileprivate var pageContentView : PageContentView!
    /*
    fileprivate lazy var pageContentView : PageContentView = {[weak self] in
        
        let contentViewFrame = CGRect(x: 0, y: kTitleH+kNavitagionBarH+kStatusBarH, width: kScreenW, height: kScreenH - kNavitagionBarH - kStatusBarH - kTitleH)
        
        var childVCs = [UIViewController]()
        childVCs.append(RecommendViewController())
//        childVCs.append(PhoneGameViewController())
//        childVCs.append(AmuseViewController())
//        childVCs.append(GameViewController())
//        childVCs.append(FunnyViewController())
 
        let pcontentView = PageContentView(frame: contentViewFrame, childVCs: childVCs, parentViewContnroller: self)
        
        pcontentView.delegate = self
        
        return pcontentView
        
    }()
 */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置UI
        setupUI()
        
        
        // 获取数据
        loadHomeCateData()
        
    }

    
    
}

// MARK: - 设置UI
extension HomeViewController {
    
     override func setupUI() {
        
        // 不需要调整UIScrollView的内边距
        automaticallyAdjustsScrollViewInsets = false
        
        // 设置导航栏
        setupNavigationItem()
        
        // 设置内容
//        setupContentView()
        super.setupUI()
        
    }
    
    private func setupNavigationItem() {
        
        // 设置导航栏背景
        
        // 设置左边的Item
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName:"homeLogoIcon")
        
        // 设置右边的Item
        let size = CGSize(width: 40, height: 40);
        let historyItem = UIBarButtonItem(imageName: "viewHistoryIcon", highImageName: "viewHistoryIconHL", size: size)
        let searchItem = UIBarButtonItem(imageName: "searchBtnIcon", highImageName: "searchBtnIconHL", size: size)
        let qrcodeItem = UIBarButtonItem(imageName: "scanIcon", highImageName: "scanIconHL", size: size)
        navigationItem.rightBarButtonItems = [historyItem, searchItem, qrcodeItem]
        
    }
    
    fileprivate func setupContentView() {
        let titleFrame = CGRect(x: 0, y: kNavitagionBarH+kStatusBarH, width: kScreenW, height: kTitleH)
        var titles = ["推荐"]
        for item in homeCateArray {
            titles.append(item.title)
        }
        pageTitleView = PageTitleView(frame: titleFrame, titles: titles)
        pageTitleView.delegate = self
        view.addSubview(pageTitleView)
        
        
        let contentViewFrame = CGRect(x: 0, y: kTitleH+kNavitagionBarH+kStatusBarH, width: kScreenW, height: kScreenH - kNavitagionBarH - kStatusBarH - kTitleH)
        
        var childVCs = [UIViewController]()
        childVCs.append(RecommendViewController())
        for item in homeCateArray {
            let anchorVC = AmuseViewController()
            anchorVC.cateModel = item
            childVCs.append(anchorVC)
        }
        
        pageContentView = PageContentView(frame: contentViewFrame, childVCs: childVCs, parentViewContnroller: self)
        pageContentView.delegate = self
        
        view.addSubview(pageContentView)
        
        
    }
    
}
// MARK: - 获取数据
extension HomeViewController {
    
    fileprivate func loadHomeCateData() {
        
        let urlString = "api/homeCate/getCateList?client_sys=ios"
        
        NetWorkTools.loadData(URLString: urlString, params: nil) { (response) in
            
            guard let result = response as? [String : Any] , let resultData = result["data"] as? [[String : Any]] else {
                self.loadFiled()
                return
            }
            
            for dict in resultData {
                let cateModel = HomeCateModel(dict: dict)
                self.homeCateArray.append(cateModel)
            }
            
            // 设置contentView
            self.setupContentView()
            
            self.loadDataFinished()
            
        }
        
    }
}

// MARK: - PageTitleViewDelegate, PageContentViewDelegate
extension HomeViewController: PageTitleViewDelegate, PageContentViewDelegate {
    
    func pageTitleView(_ titleView: PageTitleView, selectedIndex index: Int) {
        
        // 让collectionView滚动到指定位置
        pageContentView.setCurrentIndex(index: index)
        
    }
    
    func pageContentView(_ contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        
        pageTitleView.setTitleWithProgress(progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
        
        
    }
    
}
