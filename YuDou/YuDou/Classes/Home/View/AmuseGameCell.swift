//
//  AmuseGameCell.swift
//  YuDou
//
//  Created by Bemagine on 2017/1/23.
//  Copyright © 2017年 bemagine. All rights reserved.
//

import UIKit

class AmuseGameCell: UICollectionViewCell {
    
    lazy var iconView : UIImageView =  UIImageView()
        
    lazy var title : UILabel = {
        
        let title = UILabel()
        title.font = UIFont.systemFont(ofSize: 14)
        title.textAlignment = .center
        return title
        
    }()
    
    var gameModel: BaseGroupRoomModel? {
        didSet {
            guard let gameModel = gameModel else { return }
            
            title.text = gameModel.tag_name
            
            let url = URL(string: gameModel.icon_url!)
            iconView.kf.setImage(with: url, placeholder: UIImage(named: "Img_default"))
            
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension AmuseGameCell {
    
    fileprivate func setupUI() {
        
        for subv in contentView.subviews {
            subv.removeFromSuperview()
        }
        
        iconView.frame = CGRect(x: contentView.frame.width / 4, y: contentView.frame.width / 4, width: contentView.frame.width / 2, height: contentView.frame.width / 2)
        iconView.layer.cornerRadius = iconView.frame.width / 2.0
        iconView.layer.masksToBounds = true
        contentView.addSubview(iconView)
        
        title.frame = CGRect(x: 0, y: iconView.frame.height + iconView.frame.origin.y + 5, width: contentView.frame.width, height: 20)
        
        contentView.addSubview(title)
        
    }
}
