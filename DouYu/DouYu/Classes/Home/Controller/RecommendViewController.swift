//
//  RecommendViewController.swift
//  DouYu
//
//  Created by Plo on 2017/6/19.
//  Copyright © 2017年 Plo. All rights reserved.
//

import UIKit

// Mark : - 定义常量
//item边距
fileprivate let kItemMargin : CGFloat = 5
//item宽
fileprivate let kItemW : CGFloat = (kScreenW - kItemMargin * 3) / 2
//item高
fileprivate let kItemH : CGFloat = kItemW * 3/4
//带轮播图的headerView的高
fileprivate let kCycleScrollHeaderH : CGFloat = 330
//普通的headerView的高
fileprivate let kNormalHeaderH : CGFloat = 50

//注册的一些views
fileprivate let kNormalCell : String = "kCollectionNormalCell"
fileprivate let kPrettyCell : String = "kCollectionPrettyCell"
fileprivate let kCycleScrollHeaderID : String = "kCycleScrollHeaderID"
fileprivate let kNormalHeaderID : String = "kNormalHeaderID"



// Mark : - 系统回调函数
class RecommendViewController: UIViewController {
    
    var cycModels : [CycleModel]?
    
    // Mark : - 懒加载
    fileprivate lazy var recommendVM = RecommendViewModel()
    fileprivate lazy var collectionView : UICollectionView = { [ unowned self ] in
        let flowLayout = UICollectionViewFlowLayout()
//        flowLayout.itemSize = CGSize(width: kItemW, height: kItemH)
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = kItemMargin
        flowLayout.scrollDirection = .vertical
        flowLayout.headerReferenceSize = CGSize(width: kScreenW, height: kNormalHeaderH)
        flowLayout.sectionInset = UIEdgeInsetsMake(0, kItemMargin, 0, kItemMargin)
        
        let coll = UICollectionView(frame: self.view.bounds, collectionViewLayout: flowLayout)
        coll.showsHorizontalScrollIndicator = false
        coll.bounces = false
        coll.dataSource = self
        coll.delegate = self
        coll.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        coll.backgroundColor = UIColor.white
        coll.register(AppPrettyCollectionViewCell.self, forCellWithReuseIdentifier: kPrettyCell)
        coll.register(AppCommonCollectionViewCell.self, forCellWithReuseIdentifier: kNormalCell)
        
        coll.register(RecommendCycleScrollHeaderView.self, forSupplementaryViewOfKind:UICollectionElementKindSectionHeader, withReuseIdentifier: kCycleScrollHeaderID)
        coll.register(RecommendNormalHeaderView.self, forSupplementaryViewOfKind:UICollectionElementKindSectionHeader, withReuseIdentifier: kNormalHeaderID)
        
        
        return coll
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestData()
        
        setupUI()
    }


}

// Mark : - 设置UI
extension RecommendViewController {

    fileprivate func setupUI() {
        
        view.addSubview(collectionView)
    
    }
}
// Mark : - 请求数据
extension RecommendViewController {
    
    fileprivate func requestData() {
        
        
        recommendVM.requestData {
            print("---requestData")
            self.collectionView.reloadData()
        }

        recommendVM.requestCycleData {
            print("requestCycleData")
            self.collectionView.reloadData()
        }
    }
}

// Mark : - UICollectionViewDataSource 
extension RecommendViewController : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let group = recommendVM.anchorGroups[section]
        
        return group.anchors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let group = recommendVM.anchorGroups[indexPath.section]
        let anchor = group.anchors[indexPath.item]

        var cell : BaseCollectionViewCell!
        
        if indexPath.section == 1 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCell, for: indexPath) as! AppPrettyCollectionViewCell
        }else {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCell, for: indexPath) as! AppCommonCollectionViewCell
        }
        
        cell.anchor = anchor
        
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return recommendVM.anchorGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if indexPath.section == 0 {
            let headView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kCycleScrollHeaderID, for: indexPath) as! RecommendCycleScrollHeaderView
            
            headView.group = recommendVM.anchorGroups[indexPath.section]

            headView.modelGroup = recommendVM.cycleModels
            
            print("----\(headView.modelGroup)")
            
            return headView
        }else {
            let headView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kNormalHeaderID, for: indexPath) as! RecommendNormalHeaderView
            headView.group = recommendVM.anchorGroups[indexPath.section]
            return headView
        }
        
    }
    
}

// Mark : - UICollectionViewDelegate
extension RecommendViewController : UICollectionViewDelegate {

    
}

// Mark : - UICollectionViewFlowLayout
extension RecommendViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var size = CGSize(width: kItemW, height: kItemH)
        if indexPath.section == 1 {
            size = CGSize(width: kItemW, height: kItemH + kSpacingBetweenControls * 8)
        }
        return size
        
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        var size = CGSize(width: kScreenW, height: kNormalHeaderH)
        
        if section == 0 {
            size = CGSize(width: kScreenW, height: kCycleScrollHeaderH)
        }
        
        return size
    }
}

