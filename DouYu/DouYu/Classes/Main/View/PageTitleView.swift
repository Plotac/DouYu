//
//  PageTitleView.swift
//  DouYu
//
//  Created by Plo on 2017/6/14.
//  Copyright © 2017年 Plo. All rights reserved.
//

import UIKit

//Mark: - 定义常量
private let kScrollLineH : CGFloat = 2
private let kNormalColor : (CGFloat,CGFloat,CGFloat) = (85,85,85)
private let kSelectColor : (CGFloat,CGFloat,CGFloat) = (255,128,0)

//Mark: - 定义协议
protocol PageTitleViewDelegate : class{
    func pagetTitleView(titleView: PageTitleView,selectIndex: Int)
}

//Mark: - 定义PageTitleView类
class PageTitleView : UIView {
    
    //定义属性
    //标题数组
    fileprivate var titles : [String]
    fileprivate var currentIndex : Int = 0
    weak var delegate : PageTitleViewDelegate?
    
    
    //懒加载属性
    fileprivate lazy var titleLabels : [UILabel] = [UILabel]()
    //滚动视图
    fileprivate lazy var scrollView : UIScrollView = {
        let scroll = UIScrollView()
        scroll.showsHorizontalScrollIndicator = false
        scroll.scrollsToTop = false
        scroll.bounces = false
        return scroll
    }()
    //滑块
    fileprivate lazy var scrollLine : UIView = {
        let line = UIView()
        line.backgroundColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        return line
    }()
    
    // Mark: - 自定义构造函数
    init(frame: CGRect , titles: [String]) {
        
        self.titles = titles;
        super.init(frame: frame)
        
        setUpUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

//Mark: - 设置UI
extension PageTitleView {

    fileprivate func setUpUI() {
        //添加ScrollView
        addSubview(scrollView)
        scrollView.frame = bounds
        
        //创建label
        setUpTitleLabels()
        
        //创建滑块和底线
        setUpBottomLineAndScrollLine()
    }
    
    private func setUpTitleLabels() {
        let labelW : CGFloat = frame.width/CGFloat(self.titles.count)
        let labelH : CGFloat = frame.height - kScrollLineH
        let labelY : CGFloat = 0.0
        
        for (index,title) in self.titles.enumerated() {
            let  label = UILabel()
            label.font = UIFont.systemFont(ofSize: 16.0)
            label.textAlignment = .center
            label.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
            label.tag = index
            label.text = title
            label.isUserInteractionEnabled = true
            
            let labelX = CGFloat(index) * labelW
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            scrollView.addSubview(label)
            titleLabels.append(label)
            
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(self.labelClick(tap:)))
            label.addGestureRecognizer(tapGes)
        }
    }

    private func setUpBottomLineAndScrollLine() {
    
        //底部横线
        let bottomLine = UIView()
        let lineH : CGFloat = 0.5
        
        bottomLine.frame = CGRect(x: 0, y: frame.height-lineH, width: frame.size.width, height: lineH)
        bottomLine.backgroundColor = UIColor.lightGray
        addSubview(bottomLine)
        
        //滑块
        scrollView.addSubview(scrollLine)
        guard let firstLabel = titleLabels.first else { return }
        firstLabel.textColor = UIColor.orange
        scrollLine.frame = CGRect(x: 10, y: frame.height-kScrollLineH, width: firstLabel.frame.width-10*2, height: kScrollLineH)
        
    }
}

//Mark: - 监听label点击事件
extension PageTitleView {

    @objc fileprivate func labelClick(tap : UITapGestureRecognizer) {
        
        
        //1.拿到点击之后的当前label
        guard let currentLabel = tap.view as? UILabel else {
            return
        }
        
        if currentIndex == currentLabel.tag {
            delegate?.pagetTitleView(titleView: self, selectIndex: currentIndex)
            return
        }
        
        currentLabel.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        
        //2.点击之前的旧label
        let oldLabel = titleLabels[currentIndex]
        oldLabel.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
        
        currentIndex = currentLabel.tag
        
        //3.滑块位置改变
        let linePositionX = currentLabel.frame.width * CGFloat(currentLabel.tag) + 10
        UIView.animate(withDuration: 0.15) {
            self.scrollLine.frame.origin.x = linePositionX
        }
        
        delegate?.pagetTitleView(titleView: self, selectIndex: currentIndex)
    
    }
}

//Mark: - 对外暴露的方法
extension PageTitleView {
    func setTitlesWith(progress: CGFloat,sourceIndex: Int,targetIndex: Int) {

        //取出sourceLabel和targetLabel
        let sourceLabel = titleLabels[sourceIndex]
        let targetLabel = titleLabels[targetIndex]
        
        //滑块渐变
        let moveTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveX = moveTotalX * progress
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + 10 + moveX
        
        //颜色渐变
        //1.颜色变化的总范围
        let colorRange = (kSelectColor.0 - kNormalColor.0,kSelectColor.1 - kNormalColor.1,kSelectColor.2 - kNormalColor.2)
        
        //2.变化sourceLabel颜色
        sourceLabel.textColor = UIColor(r: kSelectColor.0 - colorRange.0 * progress, g: kSelectColor.1 - colorRange.1 * progress, b: kSelectColor.2 - colorRange.2 * progress)
        
        //3.变化targetLabel颜色
        targetLabel.textColor = UIColor(r: kNormalColor.0 + colorRange.0 * progress, g: kNormalColor.1 + colorRange.1 * progress, b: kNormalColor.2 + colorRange.2 * progress)
        
        //4.记录最新的Index
        currentIndex = targetIndex
        
    }
}
