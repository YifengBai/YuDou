//
//  LiveHeaderCell.swift
//  YuDou
//
//  Created by Bemagine on 2017/2/9.
//  Copyright © 2017年 bemagine. All rights reserved.
//

import UIKit

class LiveHeaderCell: UICollectionViewCell {
    
    override var isSelected: Bool {
        didSet{
            
            if isSelected {
                gameItem.textColor = ThemColor
                gameItem.layer.borderColor = ThemColor.cgColor
            } else {
                gameItem.textColor = UIColor.lightGray
                gameItem.layer.borderColor = UIColor.lightGray.cgColor
            }
        }
    }
    
    fileprivate lazy var gameItem: UILabel = {
    
        let label = UILabel()
        label.textColor = UIColor.lightGray
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        return label
    }()
    
    var gameIconModel: GameIconModel? {
        didSet {
            
            guard let model = gameIconModel  else {
                return
            }
            
           YFLog(message:  model.short_name ??? "unknown")
            
            gameItem.text = model.tag_name
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        guard let tagname = gameIconModel?.tag_name else { return }
        
        let w = tagname.boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: self.contentView.frame.height), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 14)], context: nil).size.width
        
        gameItem.frame = CGRect(x: 5, y: 5, width: w + 15, height: contentView.frame.height - 10)
        
        gameItem.layer.borderColor = UIColor.lightGray.cgColor
        gameItem.layer.borderWidth = 1
        gameItem.layer.cornerRadius = gameItem.frame.height / 2
        gameItem.layer.masksToBounds = true
        
    }
    
}

extension LiveHeaderCell {
    
    fileprivate func setupView() {
        contentView.addSubview(gameItem)
        
    }
}
