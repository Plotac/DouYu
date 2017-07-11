//
//  BaseCollectionViewCell.swift
//  DouYu
//
//  Created by Plo on 2017/6/30.
//  Copyright © 2017年 Plo. All rights reserved.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    
    var imgView : UIImageView = UIImageView()
    var audienceLab : UILabel = UILabel()
    var performerLab : UILabel = UILabel()
    
    var anchor : AnchorModel? {
        
        didSet {
            guard let anchor = anchor else {
                return
            }
            imgView.sd_setImage(with: URL.init(string: (anchor.vertical_src)), placeholderImage: UIImage(named:"prettycellPlaceholder"), options: .retryFailed)
            if anchor.online < 1000000 && anchor.online >= 10000 {
                audienceLab.text = String(format:"%.1f万",(Float(anchor.online) / 10000.0))
            }else if anchor.online >= 1000000 {
                audienceLab.text = "\(anchor.online / 1000000)万"
            }else {
                audienceLab.text = "\(anchor.online)"
            }
            performerLab.text = anchor.nickname
        }
        
    }
    
    
}
