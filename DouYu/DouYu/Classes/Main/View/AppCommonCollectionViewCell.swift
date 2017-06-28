//
//  AppCommonCollectionViewCell.swift
//  DouYu
//
//  Created by Plo on 2017/6/27.
//  Copyright © 2017年 Plo. All rights reserved.
//

import UIKit


class AppCommonCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        
        setupUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AppCommonCollectionViewCell {

    fileprivate func setupUI() {
        
        let cellWidth : CGFloat = self.bounds.width
        
        //imageView
        let imgView = UIImageView(image: UIImage(named: "normalcellPlaceholder"))
        contentView.addSubview(imgView)
        imgView.clipsToBounds = true
        imgView.layer.cornerRadius = 8
        imgView.snp.makeConstraints { (make) in
            make.left.top.equalTo(self)
            make.size.equalTo(CGSize(width: cellWidth, height: cellWidth * (1/2) + kSpacingBetweenControls))
        }
        
        //imageView右上角View
        let rightGraduatedViewWidth : CGFloat = 60
        let rightGraduatedViewHeight : CGFloat = 20
        
        let rightGraduatedView = UIView()
        rightGraduatedView.backgroundColor = UIColor.clear
        imgView.addSubview(rightGraduatedView)
        
        //颜色渐变 http://swift.gg/2016/09/13/cagradientlayer/
        let layer = CAGradientLayer()
        layer.frame = CGRect(x: 0, y: 0, width: rightGraduatedViewWidth, height: rightGraduatedViewHeight)
        layer.startPoint = CGPoint(x: 0, y: 0.5)
        layer.endPoint = CGPoint(x: 1, y: 0.5)
        
        let whiteColor = UIColor.white.withAlphaComponent(0.5).cgColor
        let blackColor = UIColor.black.withAlphaComponent(0.5).cgColor
        layer.colors = [whiteColor,blackColor]
        layer.backgroundColor = UIColor.clear.cgColor
        rightGraduatedView.layer.addSublayer(layer)
        
        rightGraduatedView.snp.makeConstraints { (make) in
            make.right.top.equalToSuperview()
            make.size.equalTo(CGSize(width: rightGraduatedViewWidth, height: rightGraduatedViewHeight))
        }

        
        //rightGraduatedView上的观看人数
        let audienceLab = UILabel()
        audienceLab.text = "90.0万"
        audienceLab.font = UIFont.systemFont(ofSize: 10)
        audienceLab.textColor = UIColor.white
        audienceLab.textAlignment = .right
        let getWidthFunc = String.ja_widthForComment(audienceLab.text!)
        rightGraduatedView.addSubview(audienceLab)
        audienceLab.snp.makeConstraints { (make) in
            make.top.equalTo(self)
            make.right.equalTo(self).offset(-5)
            make.size.equalTo(CGSize(width: getWidthFunc(10,rightGraduatedViewHeight), height: rightGraduatedViewHeight))
        }
        
        //rightGraduatedView上的观看人数图标
        let audienceIcon = UIImageView(image: UIImage(named: "AudienceIcon"))
        rightGraduatedView.addSubview(audienceIcon)
        audienceIcon.snp.makeConstraints { (make) in
            make.centerY.equalTo(audienceLab)
            make.left.equalTo(rightGraduatedView).offset(2)
            make.size.equalTo(CGSize(width: 11, height: 11))
        }
        
        //imageView上的主播图标
        let performerIcon = UIImageView(image: UIImage(named: "PerformerIcon_white"))
        imgView.addSubview(performerIcon)
        performerIcon.snp.makeConstraints { (make) in
            make.left.equalTo(imgView).offset(5)
            make.bottom.equalTo(imgView).offset(-4)
            make.size.equalTo(CGSize(width: 11, height: 11))
        }
        
        //imageView上的主播名
        let performerLab = UILabel()
        performerLab.text = "老实憨厚的笑笑"
        performerLab.font = UIFont.systemFont(ofSize: 10)
        performerLab.textColor = UIColor.white
        performerLab.textAlignment = .left
        imgView.addSubview(performerLab)
        performerLab.snp.makeConstraints { (make) in
            make.left.equalTo(performerIcon.snp.right).offset(5)
            make.centerY.equalTo(performerIcon)
            make.size.equalTo(CGSize(width: 100, height: rightGraduatedViewHeight))
        }

        //主播标题
        let titleLab = UILabel()
        contentView.addSubview(titleLab)
        titleLab.text = "老陶：蠢货们啊哈哈哈哈哈哈哈哈哈哈"
        titleLab.font = UIFont.systemFont(ofSize: 12)
        titleLab.textColor = UIColor(r: 103, g: 103, b: 103)
        titleLab.snp.makeConstraints { (make) in
            make.left.equalTo(imgView)
            make.top.equalTo(imgView.snp.bottom).offset(5)
            make.size.equalTo(CGSize(width: cellWidth, height: 15))
        }
        

    }
    

}
