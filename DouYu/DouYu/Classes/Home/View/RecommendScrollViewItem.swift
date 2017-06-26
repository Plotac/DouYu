//
//  RecommendScrollViewItem.swift
//  DouYu
//
//  Created by Plo on 2017/6/22.
//  Copyright © 2017年 Plo. All rights reserved.
//

import UIKit

fileprivate let kImageMargin : CGFloat = 30

class RecommendScrollViewItem: UIControl {
    
    fileprivate lazy var imageView : UIImageView = {
        let imgV = UIImageView()
        return imgV
    }()
    
    fileprivate lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor(r: 147, g: 147, b: 147)
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()

    init(frame:CGRect,image:UIImage,title:String = "暂无数据") {
        
        super.init(frame: frame)
        
        setupUIWith(image: image, title: title)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension RecommendScrollViewItem {

    func setupUIWith(image:UIImage,title:String) {
        imageView.image = image
        addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.centerY.equalTo(self).offset(-10)
            make.size.equalTo(CGSize(width: 34, height: 32))
        }

        titleLabel.text = title
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.centerX.equalTo(imageView)
            make.size.equalTo(CGSize(width: self.bounds.width, height: 10))
        }
        
    }
}
