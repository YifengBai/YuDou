//
//  GameCell.swift
//  YuDou
//
//  Created by Bemagine on 2017/1/20.
//  Copyright © 2017年 bemagine. All rights reserved.
//

import UIKit

class GameCell: LiveBaseCell {

    
    @IBOutlet weak var roomName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override var roomModel : BaseRoomModel? {
        didSet {
            
            super.roomModel = roomModel
            
            roomName.text = roomModel?.room_name
            
        }
    }
    

}
