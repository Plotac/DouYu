//
//  AppPrettyCollectionViewCell.swift
//  DouYu
//
//  Created by Plo on 2017/6/27.
//  Copyright © 2017年 Plo. All rights reserved.
//

import UIKit

class AppPrettyCollectionViewCell: UICollectionViewCell {
    
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
        let imgView = UIImageView(image: UIImage(named: "prettycellPlaceholder"))
        contentView.addSubview(imgView)
        imgView.clipsToBounds = true
        imgView.layer.cornerRadius = 8
        imgView.snp.makeConstraints { (make) in
            make.left.top.equalTo(self)
            make.size.equalTo(CGSize(width: cellWidth, height: cellWidth))
        }
        
        //imageView右上角View
        let rightViewWidth : CGFloat = 55
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
        let audienceLab = UILabel()
        audienceLab.text = "4396"
        audienceLab.font = UIFont.systemFont(ofSize: 11)
        audienceLab.textColor = UIColor.white
//        audienceLab.backgroundColor = UIColor.red
        audienceLab.textAlignment = .right
        let getAudienceLabWidthFunc = String.ja_widthForComment(audienceLab.text!)
        rightView.addSubview(audienceLab)
        audienceLab.snp.makeConstraints { (make) in
            make.top.equalTo(rightView)
            make.right.equalTo(rightView.snp.right).offset(-5)
            make.size.equalTo(CGSize(width: getAudienceLabWidthFunc(11,rightViewHeight), height: rightViewHeight))
        }
        
        //rightView上的观看人数图标
        let audienceIcon = UIImageView(image: UIImage(named: "AudienceIcon"))
        rightView.addSubview(audienceIcon)
        audienceIcon.snp.makeConstraints { (make) in
            make.centerY.equalTo(audienceLab)
            make.left.equalTo(rightView).offset(4)
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
        let performerLab = UILabel()
        performerLab.text = "周二喵"
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
        let locationLab = UILabel()
        locationLab.text = "牡丹江市"
        let getLocationLabWidthFunc = String.ja_widthForComment(locationLab.text!)
        locationLab.font = UIFont.systemFont(ofSize: 12)
        locationLab.textColor = UIColor(r: 120, g: 120, b: 120)
        locationLab.textAlignment = .right
        contentView.addSubview(locationLab)
        locationLab.snp.makeConstraints { (make) in
            make.right.equalTo(imgView)
            make.centerY.equalTo(performerIcon)
            make.size.equalTo(CGSize(width: getLocationLabWidthFunc(12,kSpacingBetweenControls * 2), height: kSpacingBetweenControls * 2))
        }
        
        //位置图标
        let locationIcon = UIImageView(image: UIImage(named: "PrettyCellLocationIcon"))
        contentView.addSubview(locationIcon)
        locationIcon.snp.makeConstraints { (make) in
            make.right.equalTo(locationLab.snp.left).offset(-5)
            make.centerY.equalTo(locationLab)
            make.size.equalTo(CGSize(width: 13, height: 13))
        }


    }
}
