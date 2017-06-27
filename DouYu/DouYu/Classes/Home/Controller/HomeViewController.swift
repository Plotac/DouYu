//
//  HomeViewController.swift
//  DouYu
//
//  Created by Plo on 2017/6/9.
//  Copyright © 2017年 Plo. All rights reserved.
//

import UIKit

//Mark: - 定义常量
private let kPageTitleViewH : CGFloat = 40

//Mark: - 定义HomeViewController类
class HomeViewController: UIViewController {
    private var titles : [String] = []
    
    //懒加载
    //PageTitleView
    fileprivate lazy var pageTitleView : PageTitleView = { [weak self] in
        let pageFrame = CGRect(x: 0, y: kNavgationBarH+kStatusBarH, width: kScreenW, height: kPageTitleViewH)
        self?.titles = ["推荐","手游","娱乐","游戏","趣玩"]
        let pageView = PageTitleView(frame: pageFrame, titles: (self?.titles)!)
        pageView.delegate = self
        return pageView
    }()
    //PageContentView
    fileprivate lazy var pageContentView : PageContentView = { [weak self] in
        //1.确定内容视图的frame
        let contentFrame = CGRect(x: 0, y: kStatusBarH + kNavgationBarH + kPageTitleViewH, width: kScreenW, height: kScreenH-kStatusBarH-kNavgationBarH-kPageTitleViewH-kTabBarH)
        
        //2.确定所有子视图
        var childVCs = [UIViewController]()
        
        childVCs.append(RecommendViewController())
        for _ in 0..<(self?.titles)!.count - 1 {
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            childVCs.append(vc)
        }
        
        let contentView = PageContentView(frame: contentFrame, childVCs: childVCs, parentVC: self)
        contentView.delegate = self
        return contentView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
        
    }
}

//Mark: - 设置UI界面
extension HomeViewController {
    fileprivate func setUpUI() {
        automaticallyAdjustsScrollViewInsets = false
        
        //设置导航栏
        setUpNavBar()
        
        //设置顶部TitleView
        view.addSubview(pageTitleView)
        
        //设置ContentView
        view.addSubview(pageContentView)
        pageContentView.backgroundColor = UIColor.purple
        
    }
    
    private func setUpNavBar() {

        navigationController?.navigationBar.barTintColor = UIColor.orange
        
        //导航栏右侧左侧logo
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "HomeNav_Logo", highlightedImageName: "", itemSize: CGSize.zero)
        
        //搜索框
        let seachTF = UITextField()
        seachTF.backgroundColor = UIColor.white
        seachTF.layer.cornerRadius = 3
        seachTF.clipsToBounds = true
        seachTF.frame = CGRect(x: 0.0, y: 0.0, width: 160, height: 30);
        navigationItem.titleView = seachTF

        //搜索框右侧View
        let tf_RightView = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: 27))
        //二维码按钮
        let QRCodeBtn = UIButton(type: .custom)
        QRCodeBtn.setImage(UIImage(named:"HomeNav_QRCode"), for: UIControlState.normal)
        QRCodeBtn.setImage(UIImage(named:"HomeNav_QRCode_HL"), for: UIControlState.selected)
        QRCodeBtn.frame = CGRect(x: 5, y:0, width: 27.0, height: 27.0)
        tf_RightView.addSubview(QRCodeBtn)
        //竖线
        let verticalLine = UILabel(frame: CGRect(x: 0, y: 3, width: 1.5, height: 20))
        verticalLine.backgroundColor = UIColor(red: 228/255.0, green: 228/255.0, blue: 228/255.0, alpha: 1)
        tf_RightView.addSubview(verticalLine)
        
        //搜索框左侧View
        let searchBtn = UIButton(type: .custom)
        searchBtn.setImage(UIImage(named:"HomeNav_Search"), for: UIControlState.normal)
        searchBtn.setImage(UIImage(named:"HomeNav_QRCode_HL"), for: UIControlState.selected)
        searchBtn.frame = CGRect(x: 5, y:0, width: 29.0, height: 29.0)
        tf_RightView.addSubview(QRCodeBtn)
        
        seachTF.rightView = tf_RightView
        seachTF.leftView = searchBtn
        seachTF.rightViewMode = .always
        seachTF.leftViewMode = .always
        
        //游戏中心按钮
        let itemSize = CGSize(width: 30, height: 30)
//        let gameCenterItem = UIBarButtonItem.dy_barButtonItem(imageName: "HomeNav_GameCenter", highlightedImageName: "HomeNav_GameCenter_HL", itemSize: itemSize)
        let gameCenterItem = UIBarButtonItem(imageName: "HomeNav_GameCenter", highlightedImageName: "HomeNav_GameCenter_HL", itemSize: itemSize)
        
        //历史按钮
        let historyItem = UIBarButtonItem(imageName: "HomeNav_History", highlightedImageName: "HomeNav_History_HL", itemSize: itemSize)
        
        navigationItem.rightBarButtonItems = [historyItem,gameCenterItem]
    }

}

//Mark: - PageTitleViewDelegate
extension HomeViewController : PageTitleViewDelegate {

    func pagetTitleView(titleView: PageTitleView, selectIndex: Int) {
        pageContentView.setContentViewCurrentIndex(index: selectIndex)
    }
}

//Mark: - PageContentViewDelegate 
extension HomeViewController : PageContentViewDelegate {
    func pageContentView(pageContentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView.setTitlesWith(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}
