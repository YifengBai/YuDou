//
//  LiveHeaderCategoryView.swift
//  YuDou
//
//  Created by Bemagine on 2017/2/8.
//  Copyright © 2017年 bemagine. All rights reserved.
//

import UIKit

private let LiveHeaderCategoryCellId = "LiveHeaderCategoryCellId"

protocol LiveHeaderCategoryViewDelegate : class {
    
    func headerCategoryBtnClick(headerView: LiveHeaderCategoryView, tagId: String?)
    
}

class LiveHeaderCategoryView: UIView {

    lazy var scrollView: UIScrollView = {
    
        let scv = UIScrollView(frame: CGRect(x: 0, y: 0, width: kScreenW-40, height: 40))
        
        scv.bounces = false
        scv.backgroundColor = UIColor.white
        scv.showsVerticalScrollIndicator = false
        scv.showsHorizontalScrollIndicator = false
        
        return scv
    }()
    
    lazy var collectionView : UICollectionView = {[unowned self] in
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: kScreenW-40, height: 40), collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(LiveHeaderCell.self, forCellWithReuseIdentifier: LiveHeaderCategoryCellId)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        
        return collectionView
    }()
    
    
    lazy var moreBtn : UIButton = {
    
        let btn = UIButton(frame: CGRect(x: kScreenW-40, y: 0, width: 40, height: 40))
        
        btn.setImage(UIImage(named: "three_column_view_open"), for: .normal)
        btn.setImage(UIImage(named: "column_up_icon"), for: .selected)
        
//        btn.setBackgroundImage(UIImage(named: "three_column_view_open"), for: .normal)
        
        btn.addTarget(self, action: #selector(self.moreDetailBtnClick), for: .touchUpInside)
        
        return btn
        
    }()
    
    weak var  delegate: LiveHeaderCategoryViewDelegate?
    
    fileprivate var selectedBtn : UIButton?
    
    var itemArray: [GameIconModel]? {
        didSet {
            guard itemArray != nil else {
                return
            }
//            setupScrollSubView()
            collectionView.reloadData()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: - UI
extension LiveHeaderCategoryView {
    
    fileprivate func setupView() {
        
//        addSubview(scrollView)
        addSubview(collectionView)
        
        addSubview(moreBtn)
        
    }
    
    fileprivate func setupScrollSubView() {
        
        for subview in scrollView.subviews {
            subview.removeFromSuperview()
        }
        
        let btnMargin: CGFloat = 5
        var btnX: CGFloat = btnMargin
        let btnY: CGFloat = 5
        let btnH: CGFloat = frame.height - 10
        
        for (index, item) in itemArray!.enumerated() {
            
            // 计算字符串的宽度，高度
            let font : UIFont = UIFont.systemFont(ofSize: 14)
            let attributes = [NSFontAttributeName:font]
            let option = NSStringDrawingOptions.usesLineFragmentOrigin
            let btnW : CGFloat = item.tag_name.boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: btnH), options: option, attributes: attributes, context: nil).size.width + 15.0
            
            let btn = UIButton(frame: CGRect(x: btnX, y: btnY, width: btnW, height: btnH))
            btn.setTitle(item.tag_name, for: .normal)
            btn.titleLabel?.font = font
            btn.setTitleColor(UIColor.lightGray, for: .normal)
            btn.setTitleColor(ThemColor, for: .selected)
            btn.tag = index
            
            if index == 0 {
                btn.isSelected = true
                selectedBtn = btn
            }
            
            btn.layer.borderColor = UIColor.lightGray.cgColor
            btn.layer.borderWidth = 1
            btn.layer.cornerRadius = btnH / 2
            btn.layer.masksToBounds = true
            
            btn.addTarget(self, action: #selector(self.itemClick(btn:)), for: .touchUpInside)
            
            scrollView.addSubview(btn)
            
            btnX = btnX + btnW + btnMargin
            
        }
        
        scrollView.contentSize = CGSize(width: btnX, height: 0)
        
    }
    
}

extension LiveHeaderCategoryView: UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemArray?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LiveHeaderCategoryCellId, for: indexPath) as! LiveHeaderCell
        
        let item = (itemArray?[indexPath.item])!
        
        cell.gameIconModel = item
        
        if indexPath.item == 0 {
            cell.isSelected = true
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        guard let item = itemArray?[indexPath.item] else { return }
        
        delegate?.headerCategoryBtnClick(headerView: self, tagId: item.tag_id)
        
        
    }
    
    
}

extension LiveHeaderCategoryView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let item = (itemArray?[indexPath.row])!
        
        let w = item.tag_name.boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: 40), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 14)], context: nil).size.width
        
        return CGSize(width: w + 25, height: 40)
        
    }
    
}

// MARK: - 内部方法
extension LiveHeaderCategoryView {
    
    @objc fileprivate func itemClick(btn: UIButton) {
        
        if btn == selectedBtn {
            return
        }
        
        selectedBtn?.isSelected = !(selectedBtn?.isSelected)!
        selectedBtn = btn
        btn.isSelected = !btn.isSelected
        
        guard let item = itemArray?[btn.tag] else { return }
        
        delegate?.headerCategoryBtnClick(headerView: self, tagId: item.tag_id!)
        
    }
    
    @objc fileprivate func moreDetailBtnClick() {
        
        
        
        
        
    }
    
}

