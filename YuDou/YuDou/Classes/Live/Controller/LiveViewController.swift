//
//  LiveViewController.swift
//  YuDou
//
//  Created by Bemagine on 2017/1/23.
//  Copyright © 2017年 bemagine. All rights reserved.
//

import UIKit

class LiveViewController: BaseViewController {
    
    fileprivate lazy var titleArray: [ColumnModel] = [ColumnModel]()
    
    fileprivate var navTitleView : ScrollSegement!
    
    fileprivate var childContentView : PageContentView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        
        navigationItem.title = "直播"
        
        loadData()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.transformNavigationBar(noti:)), name: NSNotification.Name(rawValue: NotificationNavigationBarTransform), object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}
// MARK: - UI
extension LiveViewController {
    
    fileprivate func setupView() {
        
        // 设置navTitleView
        setupNavTitleView()
        
        // 设置childContentView
        setupChildContentView()
        
    }
    
    fileprivate func setupNavTitleView() {
       
        var titles = ["常用", "全部"]
        for item in titleArray {
            titles.append(item.cate_name!)
        }
        
        navTitleView = ScrollSegement(frame:
            CGRect(x: 0, y: 0, width: kScreenW - 20, height: kNavitagionBarH - 4), titles: titles, norSelectedIndex: 1)
        navigationItem.titleView = navTitleView
        
        navTitleView.selectedIndex = {[weak self] selectedIndex in
            self?.childContentView.setCurrentIndex(index: selectedIndex)
            
        }
        
        navigationItem.titleView = navTitleView
    }
    
    fileprivate func setupChildContentView() {
        let contentViewFrame = CGRect(x: 0, y: kNavitagionBarH+kStatusBarH, width: kScreenW, height: kScreenH - kNavitagionBarH - kStatusBarH)
        
        var childVCs = [UIViewController]()
        childVCs.append(LiveCommonViewController())
        childVCs.append(LiveListViewController())
        for (_, item) in titleArray.enumerated() {
            let vc = LiveChildViewController()
            vc.shortName = item.short_name
            vc.columnModel = item
            childVCs.append(vc)
        }
        
        childContentView = PageContentView(frame: contentViewFrame, childVCs: childVCs, parentViewContnroller: self)
        
        childContentView.delegate = self
        
        childContentView.setCurrentIndex(index: navTitleView.curSelectedIndex)

        contentView = childContentView
        
        view.addSubview(childContentView)
        
    }
    
   
}
// MARK: - 加载数据
extension LiveViewController {
    
    fileprivate func loadData() {
        
        let url = "api/v1/getColumnList?client_sys=ios"
        
        NetWorkTools.loadData(URLString: url, params: nil) { (response) in
            
            guard let resultDict = response as? [String : Any] else {
                self.loadFiled()
                return
            }
            guard let dataArray = resultDict["data"] as? [[String : Any]] else {
                self.loadFiled()
                return
            }

            for item in dataArray {
                let model = ColumnModel(dict: item)
                self.titleArray.append(model)
            }
            
            self.loadDataFinished()
            
            self.setupView()
            
        }
        
        
    }
    
}

extension LiveViewController {
    
    @objc fileprivate func transformNavigationBar(noti: Notification) {
        
        let objc = noti.object as! ScrollDirection
        
        if objc == .ScrollUp {
            
            if self.childContentView.frame.origin.y == kNavitagionBarH+kStatusBarH {
                return
            }
            UIView.animate(withDuration: 0.2, animations: {
                self.childContentView.frame = CGRect(x: 0, y: kNavitagionBarH+kStatusBarH, width: kScreenW, height: kScreenH - kNavitagionBarH - kStatusBarH)
//                self.childContentView.transform = CGAffineTransform.identity
            })
            
        } else {
            if self.childContentView.frame.origin.y == kStatusBarH {
                return
            }
            UIView.animate(withDuration: 0.2, animations: {
                self.childContentView.frame = CGRect(x: 0, y: kStatusBarH, width: kScreenW, height: kScreenH - kStatusBarH)
//                self.childContentView.transform = CGAffineTransform(translationX: 0, y: -kNavitagionBarH)
//                self.childContentView.transform = CGAffineTransform(scaleX: 1, y: kScreenH - kStatusBarH / kScreenH - kNavitagionBarH - kStatusBarH)
//                self.childContentView.frame.size.height = kScreenH - kStatusBarH
            })
        }
        super.navigationBarTransform(direction: objc)
        
        
    }
    
}

// MARK: - PageContentViewDelegate
extension LiveViewController : PageContentViewDelegate {
    
    func pageContentView(_ contentView : PageContentView, progress : CGFloat, sourceIndex : Int, targetIndex : Int){
        navTitleView.setTitleLabelWithProgress(progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
    
}
