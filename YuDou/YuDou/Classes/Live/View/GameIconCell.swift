//
//  GameIconCell.swift
//  YuDou
//
//  Created by Bemagine on 2017/2/8.
//  Copyright © 2017年 bemagine. All rights reserved.
//

import UIKit

class GameIconCell: UICollectionViewCell {
    
    @IBOutlet weak var gameIcon: UIImageView!
    
    @IBOutlet weak var gameName: UILabel!
    
    override func awakeFromNib() {
        
    }
    
    var gameModel: GameIconModel? {
        didSet {
            
            guard let gameModel = gameModel else {
                return
            }
            
            gameIcon.kf.setImage(with: URL(string: gameModel.icon_url!), placeholder: UIImage(named: "live_cell_default_phone"))
            
            gameName.text = gameModel.tag_name
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        gameIcon.layer.cornerRadius = gameIcon.frame.width / 2
        gameIcon.layer.masksToBounds = true
    }
    
    
}
