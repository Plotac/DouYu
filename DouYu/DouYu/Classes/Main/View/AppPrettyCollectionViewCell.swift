//
//  AppPrettyCollectionViewCell.swift
//  DouYu
//
//  Created by Plo on 2017/6/27.
//  Copyright © 2017年 Plo. All rights reserved.
//

import UIKit

class AppPrettyCollectionViewCell: BaseCollectionViewCell {
    
    //控件设置
    var locationLab : UILabel = UILabel()
    
    
    override var anchor : AnchorModel? {
    
        didSet {
            //将属性传递给父类
            super.anchor = anchor
            
            //设置属性
            locationLab.text = anchor?.anchor_city
        }
    
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        
        setupUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension AppPrettyCollectionViewCell {
    
    fileprivate func setupUI() {
        
        let cellWidth : CGFloat = self.bounds.width
        
        //imageView
        contentView.addSubview(imgView)
        imgView.clipsToBounds = true
        imgView.layer.cornerRadius = 8
        imgView.snp.makeConstraints { (make) in
            make.left.top.equalTo(self)
            make.size.equalTo(CGSize(width: cellWidth, height: cellWidth))
        }
        
        //imageView右上角View
        let rightViewWidth : CGFloat = 57
        let rightViewHeight : CGFloat = 25
        
        let rightView = UIView()
        rightView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        rightView.clipsToBounds = true
        rightView.layer.cornerRadius = 4
        imgView.addSubview(rightView)
        rightView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(5)
            make.right.equalToSuperview().offset(-5)
            make.size.equalTo(CGSize(width: rightViewWidth, height: rightViewHeight))
        }
        
        //rightView上的观看人数
        audienceLab.font = UIFont.systemFont(ofSize: 11)
        audienceLab.textColor = UIColor.white
        audienceLab.textAlignment = .center
        rightView.addSubview(audienceLab)
        audienceLab.snp.makeConstraints { (make) in
            make.top.equalTo(rightView)
            make.right.equalTo(rightView.snp.right).offset(-5)
            make.size.equalTo(CGSize(width: 40, height: rightViewHeight))
        }
        
        //rightView上的观看人数图标
        let audienceIcon = UIImageView(image: UIImage(named: "AudienceIcon"))
        rightView.addSubview(audienceIcon)
        audienceIcon.snp.makeConstraints { (make) in
            make.centerY.equalTo(audienceLab)
            make.right.equalTo(audienceLab.snp.left).offset(1)
            make.size.equalTo(CGSize(width: 11, height: 11))
        }
        
        //主播图标
        let performerIcon = UIImageView(image: UIImage(named: "PerformerIcon_black"))
        contentView.addSubview(performerIcon)
        performerIcon.snp.makeConstraints { (make) in
            make.left.equalTo(imgView)
            make.top.equalTo(imgView.snp.bottom).offset(kSpacingBetweenControls)
            make.size.equalTo(CGSize(width: 13, height: 13))
        }

        //主播名
        performerLab.font = UIFont.systemFont(ofSize: 13)
        performerLab.textColor = UIColor(r: 80, g: 80, b: 80)
        performerLab.textAlignment = .left
        contentView.addSubview(performerLab)
        performerLab.snp.makeConstraints { (make) in
            make.left.equalTo(performerIcon.snp.right).offset(5)
            make.centerY.equalTo(performerIcon)
            make.size.equalTo(CGSize(width: 100, height: kSpacingBetweenControls * 2))
        }
        
        //位置label
        locationLab.font = UIFont.systemFont(ofSize: 12)
        locationLab.textColor = UIColor(r: 120, g: 120, b: 120)
        locationLab.textAlignment = .right
        contentView.addSubview(locationLab)
        locationLab.snp.makeConstraints { (make) in
            make.right.equalTo(imgView)
            make.centerY.equalTo(performerIcon)
            make.size.equalTo(CGSize(width: 40, height: kSpacingBetweenControls * 2))
        }
        
        //位置图标
        let locationIcon = UIImageView(image: UIImage(named: "PrettyCellLocationIcon"))
        contentView.addSubview(locationIcon)
        locationIcon.snp.makeConstraints { (make) in
            make.right.equalTo(locationLab.snp.left)
            make.centerY.equalTo(locationLab)
            make.size.equalTo(CGSize(width: 13, height: 13))
        }


    }
}
