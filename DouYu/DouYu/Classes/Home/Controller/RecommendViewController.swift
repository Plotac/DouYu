//
//  RecommendViewController.swift
//  DouYu
//
//  Created by Plo on 2017/6/19.
//  Copyright © 2017年 Plo. All rights reserved.
//

import UIKit

// Mark : - 定义常量
fileprivate let kItemMargin : CGFloat = 10
fileprivate let kItemW : CGFloat = kScreenW - kItemMargin * 3
fileprivate let kItemH : CGFloat = kItemW * 3/4
fileprivate let kContentCellID : String = "CollectionCell"


// Mark : - 系统回调函数
class RecommendViewController: UIViewController {

    fileprivate lazy var collectionView : UICollectionView = { [ unowned self ] in
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: kItemW, height: kItemH)
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = kItemMargin
        flowLayout.scrollDirection = .horizontal
        
        let coll = UICollectionView(frame: self.view.bounds, collectionViewLayout: flowLayout)
        coll.showsHorizontalScrollIndicator = false
        coll.bounces = false
        coll.dataSource = self
        coll.delegate = self
        coll.backgroundColor = UIColor.white
        coll.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kContentCellID)
        
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
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kContentCellID, for: indexPath)
        
        return cell
    }
    
}

// Mark : - UICollectionViewDelegate
extension RecommendViewController : UICollectionViewDelegate {

    
}

