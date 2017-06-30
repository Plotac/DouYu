//
//  RecommendNormalHeaderView.swift
//  DouYu
//
//  Created by Plo on 2017/6/26.
//  Copyright © 2017年 Plo. All rights reserved.
//

import UIKit
// Mark : - 区头view的总高度
fileprivate let kHeaderViewH : CGFloat = 50

// Mark : - 左边距
fileprivate let kMarginLeft : CGFloat = 15

class RecommendNormalHeaderView: UICollectionReusableView {
    
    var titleLab : UILabel = UILabel()
    var iconImageView : UIImageView = UIImageView()
    
    var group : AnchorGroup? {
        
        didSet {
            
            titleLab.text = group?.tag_name
            iconImageView.sd_setImage(with: URL.init(string: group?.small_icon_url ?? "YanzhiIcon"), placeholderImage: UIImage(named:"HeadViewNormalIcon"), options:.retryFailed)
            if group?.tag_name == "颜值" {
                iconImageView.image = UIImage(named: "YanzhiIcon")
            }
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

extension RecommendNormalHeaderView {
    
    fileprivate func setupUI() {
        //顶部灰色横条
        let topGrayViewH : CGFloat = 10
        
        let topGrayView = UIView()
        topGrayView.backgroundColor = UIColor(r: 235, g: 235, b: 235)
        topGrayView.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: topGrayViewH)
        addSubview(topGrayView)
        
        //分组图标
        let iconW : CGFloat = 20
        let iconH : CGFloat = 20
        let topAndBottonMargin = (kHeaderViewH - iconH - topGrayViewH) / 2
        
        iconImageView = UIImageView(image: UIImage(named:"HeadViewHotIcon"))
        iconImageView.frame = CGRect(x: kMarginLeft, y: topAndBottonMargin + topGrayViewH, width: iconW, height: iconH)
        addSubview(iconImageView)
        
        //分组label
        let titleLabW : CGFloat = 100
        let titleLabH : CGFloat = 20

        titleLab.frame = CGRect(x: iconImageView.frame.origin.x + iconW + kSpacingBetweenControls, y: iconImageView.frame.origin.y, width: titleLabW, height: titleLabH)
//        titleLab.text = "最热"
        titleLab.font = UIFont.systemFont(ofSize: 16)
        titleLab.textColor = UIColor(r: 110, g: 110, b: 110)
        addSubview(titleLab)
        
        //右侧view
        let rightViewW : CGFloat = 60
        let rightViewH : CGFloat = 30
        
        let rightView = UIView()
        rightView.frame = CGRect(x: self.bounds.width - rightViewW - kSpacingBetweenControls, y: iconImageView.frame.origin.y - kSpacingBetweenControls / 2, width: rightViewW, height: rightViewH)
        addSubview(rightView)
        
        //右侧view上的跳转图标
        let jumpIconW : CGFloat = 12
        let jumpIconH : CGFloat = 12
        
        let jumpIcon = UIImageView(image: UIImage(named: "HeadViewJumpIcon"))
        jumpIcon.frame = CGRect(x: rightView.bounds.width - jumpIconW, y: kSpacingBetweenControls - 1, width: jumpIconW, height: jumpIconH)
        rightView.addSubview(jumpIcon)
        
        //右侧view上的更多label
        let morelabW : CGFloat = 35
        let morelabH : CGFloat = 15
        
        let moreLabel = UILabel()
        moreLabel.textColor = UIColor(r: 130, g: 130, b: 130)
        moreLabel.font = UIFont.systemFont(ofSize: 14)
        moreLabel.frame = CGRect(x: jumpIcon.frame.origin.x - morelabW, y: kSpacingBetweenControls - 2, width: morelabW, height: morelabH)
        moreLabel.text = "更多"
        rightView.addSubview(moreLabel)
        
    
    }
    
}
