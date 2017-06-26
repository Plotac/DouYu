//
//  RecommendHeaderView.swift
//  DouYu
//
//  Created by Plo on 2017/6/20.
//  Copyright © 2017年 Plo. All rights reserved.
//

import UIKit
import SDCycleScrollView

fileprivate let kSDScrollViewH : CGFloat = 180

class RecommendHeaderView: UICollectionReusableView {
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.backgroundColor = UIColor(r: 235, g: 235, b: 235)
        
        setupUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate lazy var sdScrollView : SDCycleScrollView = { [weak self] in
        
        let images : [UIImage] = [UIImage(named:"cycleScrollPlaceholder")!,UIImage(named:"cycleScrollPlaceholder")!,UIImage(named:"cycleScrollPlaceholder")!,UIImage(named:"cycleScrollPlaceholder")!]
        
        let scroll = SDCycleScrollView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: kSDScrollViewH), imageNamesGroup: images)
        scroll?.currentPageDotColor = UIColor.orange
        scroll?.pageDotColor = UIColor.lightGray
//        scroll?.delegate = self as! SDCycleScrollViewDelegate!
        return scroll!
    }()
    
}

extension RecommendHeaderView {

    fileprivate func setupUI(){
        
        addSubview(sdScrollView)
        
        setupButtons()
    
    }
    fileprivate func setupButtons() {

        let images : [UIImage] = [UIImage(named:"HomeScroll_RankingList")!,UIImage(named:"HomeScroll_Message")!,UIImage(named:"HomeScroll_Activity")!,UIImage(named:"HomeScroll_Live")!]
        let titles : [String] = ["排行榜","消息","活动","全部直播"]
        
        for (index,image) in images.enumerated() {
            
            let btn = RecommendScrollViewItem(frame:CGRect(x: CGFloat(index) * (kScreenW/4), y: kSDScrollViewH, width: kScreenW/4, height: 100),image: image, title: titles[index])
            btn.backgroundColor = UIColor.white
            addSubview(btn)

        }
    }

}
