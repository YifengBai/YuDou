//
//  SectionHeaderView.swift
//  YuDou
//
//  Created by Bemagine on 2017/1/22.
//  Copyright © 2017年 bemagine. All rights reserved.
//

import UIKit

class SectionHeaderView: UICollectionReusableView {
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var iconView: UIImageView!
    
    @IBOutlet weak var sectionTitle: UILabel!

    // MARK:- 定义模型属性
    var group : BaseGroupRoomModel? {
        didSet {
            sectionTitle.text = group?.tag_name
            iconView.image = UIImage(named: group?.icon_name ?? "home_header_normal")
        }
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}

extension SectionHeaderView {
    
    class func sectionHeaderView() -> SectionHeaderView {
        return Bundle.main.loadNibNamed("SectionHeaderView", owner: nil, options: nil)?.first as! SectionHeaderView
    }
    
}
