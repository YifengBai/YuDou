//
//  LiveBaseCell.swift
//  YuDou
//
//  Created by Bemagine on 2017/1/20.
//  Copyright © 2017年 bemagine. All rights reserved.
//

import UIKit
import Kingfisher

class LiveBaseCell: UICollectionViewCell {
    
    @IBOutlet weak var nickName: UILabel!
    
    @IBOutlet weak var liveImageView: UIImageView!
    
    @IBOutlet weak var onlineBtn: UIButton!
    
    var roomModel : BaseRoomModel? {
        didSet {
            // 0.校验模型是否有值
            guard let roomModel = roomModel else { return }
            
            // 在线人数
            var online = ""
            if roomModel.online >= 10000 {
                online = String(format: "%.1f", CGFloat(roomModel.online) / 10000.0) + "万"
            } else {
                online = "\(roomModel.online)"
            }
            onlineBtn.setTitle(online, for: .normal)
            
            // 主播名称
            nickName.text =  roomModel.nickname
            
            // 房间图片
            guard let iconUrl = URL(string: roomModel.vertical_src) else { return }
            liveImageView.kf.setImage(with: iconUrl, placeholder: UIImage(named: "Img_default"))
            
        }
    }
    
}
