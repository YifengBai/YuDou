//
//  BeautyCell.swift
//  YuDou
//
//  Created by Bemagine on 2017/1/20.
//  Copyright © 2017年 bemagine. All rights reserved.
//

import UIKit

class BeautyCell: LiveBaseCell {

    @IBOutlet weak var cityBtn: UIButton!
    
    @IBOutlet weak var numLabelW: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override var roomModel: BaseRoomModel? {
        didSet {
            
            super.roomModel = roomModel
            
            cityBtn.setTitle(roomModel?.anchor_city, for: .normal)
            
        }
        
    }
    

}
