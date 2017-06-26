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
fileprivate let kItemMargin : CGFloat = 10
//item宽
fileprivate let kItemW : CGFloat = (kScreenW - kItemMargin * 3) / 2
//item高
fileprivate let kItemH : CGFloat = kItemW * 3/4
//带轮播图的headerView的高
fileprivate let kCycleScrollHeaderH : CGFloat = 290
//普通的headerView的高
fileprivate let kNormalHeaderH : CGFloat = 45

//注册的一些views
fileprivate let kContentCellID : String = "CollectionCell"
fileprivate let kCycleScrollHeaderID : String = "kCycleScrollHeaderID"
fileprivate let kNormalHeaderID : String = "kNormalHeaderID"



// Mark : - 系统回调函数
class RecommendViewController: UIViewController {

    
    
    // Mark : - 懒加载
    fileprivate lazy var collectionView : UICollectionView = { [ unowned self ] in
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: kItemW, height: kItemH)
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
        coll.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kContentCellID)
        coll.register(RecommendHeaderView.self, forSupplementaryViewOfKind:UICollectionElementKindSectionHeader, withReuseIdentifier: kCycleScrollHeaderID)
        coll.register(UICollectionReusableView.self, forSupplementaryViewOfKind:UICollectionElementKindSectionHeader, withReuseIdentifier: kNormalHeaderID)
        
        
        return coll
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        
    }


}

// Mark : - 设置UI
extension RecommendViewController {

    fileprivate func setupUI() {
        
        view.addSubview(collectionView)
    
    }
}

// Mark : - UICollectionViewDataSource 
extension RecommendViewController : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if section == 0 {
            return 8
        }
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kContentCellID, for: indexPath)
        
        cell.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
        
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 14
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        var headView = UICollectionReusableView()
        
        if indexPath.section == 0 {
            headView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kCycleScrollHeaderID, for: indexPath)
        }else {
            headView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kNormalHeaderID, for: indexPath)
            headView.backgroundColor = UIColor.purple
        }
        return headView
    }
    
}

// Mark : - UICollectionViewDelegate
extension RecommendViewController : UICollectionViewDelegate {

    
}

// Mark : - UICollectionViewFlowLayout
extension RecommendViewController : UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        var size = CGSize(width: kScreenW, height: kNormalHeaderH)
        
        if section == 0 {
            size = CGSize(width: kScreenW, height: kCycleScrollHeaderH)
        }
        
        return size
    }
}

