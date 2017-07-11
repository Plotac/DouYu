//
//  RecommendCycleScrollHeaderView.swift
//  DouYu
//
//  Created by Plo on 2017/6/20.
//  Copyright © 2017年 Plo. All rights reserved.
//

import UIKit
import SDCycleScrollView


// Mark : - 轮播图高度
fileprivate let kSDScrollViewH : CGFloat = 180
// Mark : - button高度
fileprivate let kCycleScrollButtonH : CGFloat = 100
// Mark : - 分类View高度(330-180-100)
fileprivate let kNormalViewH : CGFloat = 50

// Mark : - 左边距
fileprivate let kMarginLeft : CGFloat = 15

class RecommendCycleScrollHeaderView: UICollectionReusableView {
    
    var urlStrs : [String] = [String]()
    
    //设置属性
    var modelGroup : [CycleModel]! = [] {
        didSet {
            guard let modelGroup = modelGroup else { return }
            
            for model in modelGroup {
                urlStrs.append(model.pic_url)
            }
            sdScrollView.imageURLStringsGroup = urlStrs
        }
    }
    
    var titleLab : UILabel = UILabel()
    var iconImageView : UIImageView = UIImageView()

    var group : AnchorGroup? {
        
        didSet {
        
            titleLab.text = group?.tag_name
            
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
    
    fileprivate lazy var sdScrollView : SDCycleScrollView = { [unowned self] in

        let scroll = SDCycleScrollView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: kSDScrollViewH), delegate: self as SDCycleScrollViewDelegate!, placeholderImage: UIImage(named:"cycleScrollPlaceholder")!)
        scroll?.currentPageDotColor = UIColor.orange
        scroll?.pageDotColor = UIColor.white
        return scroll!
    }()
}

extension RecommendCycleScrollHeaderView {

    fileprivate func setupUI(){
        
        addSubview(sdScrollView)
        
        setupButtons()
        
        setupNormalViews()
    }
    
    fileprivate func setupButtons() {

        let images : [UIImage] = [UIImage(named:"HomeScroll_RankingList")!,UIImage(named:"HomeScroll_Message")!,UIImage(named:"HomeScroll_Activity")!,UIImage(named:"HomeScroll_Live")!]
        let titles : [String] = ["排行榜","消息","活动","全部直播"]
        
        for (index,image) in images.enumerated() {
            
            let btn = RecommendScrollViewItem(frame:CGRect(x: CGFloat(index) * (kScreenW/4), y: kSDScrollViewH, width: kScreenW/4, height: kCycleScrollButtonH),image: image, title: titles[index])
            btn.backgroundColor = UIColor.white
            addSubview(btn)

        }
    }
    
    fileprivate func setupNormalViews() {
        //顶部灰色横条
        let topGrayViewH : CGFloat = 10

        let topGrayView = UIView()
        topGrayView.backgroundColor = UIColor(r: 235, g: 235, b: 235)
        topGrayView.frame = CGRect(x: 0, y: kSDScrollViewH + kCycleScrollButtonH, width: self.bounds.width, height: topGrayViewH)
        addSubview(topGrayView)
        
        //组分类图标
        let iconW : CGFloat = 15
        let iconH : CGFloat = 17
        let topAndBottonMargin = (kNormalViewH - iconH - topGrayViewH) / 2
        
        iconImageView = UIImageView(image: UIImage(named:"HeadViewHotIcon"))
        iconImageView.frame = CGRect(x: kMarginLeft, y: topGrayView.frame.origin.y + topAndBottonMargin + topGrayViewH, width: iconW, height: iconH)
        addSubview(iconImageView)
        
        //组分类label
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

extension RecommendCycleScrollHeaderView : SDCycleScrollViewDelegate {
    
    func cycleScrollView(_ cycleScrollView: SDCycleScrollView!, didSelectItemAt index: Int) {
        print(index)
    }

}
