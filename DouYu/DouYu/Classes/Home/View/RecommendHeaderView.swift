//
//  RecommendHeaderView.swift
//  DouYu
//
//  Created by Plo on 2017/6/20.
//  Copyright © 2017年 Plo. All rights reserved.
//

import UIKit
import SDCycleScrollView

fileprivate let kSDScrollViewH : CGFloat = 160

class RecommendHeaderView: UICollectionReusableView {
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        setupUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate lazy var sdScrollView : SDCycleScrollView = {
        let scroll = SDCycleScrollView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: kSDScrollViewH), imageNamesGroup: ["cycleScrollPlaceholder","cycleScrollPlaceholder","cycleScrollPlaceholder","","cycleScrollPlaceholder"])
        
        return scroll!
    }()
    
}

extension RecommendHeaderView {

    fileprivate func setupUI(){
        addSubview(sdScrollView)
        
    
    }

}
