//
//  PageContentView.swift
//  DouYu
//
//  Created by Plo on 2017/6/15.
//  Copyright © 2017年 Plo. All rights reserved.
//

import UIKit

protocol PageContentViewDelegate : class {
    func pageContentView(pageContentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int)
}


private let kContentCellID : String = "ContentCell"

class PageContentView: UIView {
    // Mark: - 定义属性
    fileprivate var childVCs : [UIViewController]
    fileprivate weak var parentVC : UIViewController?
    fileprivate var startOffsetX : CGFloat = 0
    weak var delegate : PageContentViewDelegate?
    fileprivate var isForbitScrollDelegate : Bool = false

    // Mark: - 懒加载属性
    //CollectionView
    fileprivate lazy var collectionView : UICollectionView = { [weak self] in
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = (self?.bounds.size)!
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.scrollDirection = .horizontal
        
        let coll = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        coll.showsHorizontalScrollIndicator = false
        coll.isPagingEnabled = true
        coll.bounces = false
        coll.dataSource = self
        coll.delegate = self
        
        coll.register(UICollectionViewCell.classForCoder(), forCellWithReuseIdentifier: kContentCellID)
        
        return coll
    }()
    
    init(frame: CGRect,childVCs: [UIViewController],parentVC: UIViewController?) {
        
        self.childVCs = childVCs
        self.parentVC = parentVC
        
        super.init(frame: frame)
        
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// Mark: - 设置UI
extension PageContentView {
    
    fileprivate func setUpUI() {
        //1.将所有的子控制器添加到父控制器中
        for childVC in self.childVCs {
            parentVC?.addChildViewController(childVC)
        }
        //2.设置UICollectionView，用于在cell中存放控制器的view
        addSubview(collectionView)
        collectionView.frame = bounds
    }

}

// Mark: - CollectionViewDataSource
extension PageContentView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVCs.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kContentCellID, for: indexPath)
        
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        
        let childVC = childVCs[indexPath.item]
        childVC.view.frame = cell.bounds
        cell.contentView.addSubview(childVC.view)
        
        return cell
    }

}

// Mark: - CollectionViewDelegate
extension PageContentView : UICollectionViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        isForbitScrollDelegate = false
        
        startOffsetX = scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //判断是否是点击事件
        if isForbitScrollDelegate { return }
        
        var progress : CGFloat = 0
        var sourcesIndex : Int = 0
        var targetIndex : Int = 0
        
        let currentOffset : CGFloat = scrollView.contentOffset.x
        let scrollViewW : CGFloat = scrollView.bounds.width

        if currentOffset > startOffsetX {//左滑
            
            //左滑：currentOffset增加 所以currentOffset / scrollViewW 是大于0的小数
            //floor()函数 : 取整
            progress = currentOffset / scrollViewW - floor(currentOffset / scrollViewW)// x.y - x = 0.y
            
            sourcesIndex = Int(currentOffset / scrollViewW)
            
            targetIndex = sourcesIndex + 1
            if targetIndex >= childVCs.count {//防止越界
                targetIndex = childVCs.count - 1
            }
            
            //如果完全滑过去
            if currentOffset - startOffsetX == scrollViewW {
                progress = 1
                targetIndex = sourcesIndex
            }
            
            
        }else {//右滑
            //右滑：currentOffset减少 所以currentOffset / scrollViewW 是大于0小于1的小数
            progress = 1 - (currentOffset / scrollViewW - floor(currentOffset / scrollViewW))
            
            targetIndex = Int(currentOffset / scrollViewW)
            
            sourcesIndex = targetIndex + 1
            if sourcesIndex >= childVCs.count {//防止越界
                sourcesIndex = childVCs.count - 1
            }
        
        }
        
        delegate?.pageContentView(pageContentView: self, progress: progress, sourceIndex: sourcesIndex, targetIndex: targetIndex)
        
    }
}

// Mark: - 对外暴露的方法
extension PageContentView {
    
    func setContentViewCurrentIndex(index: Int) {
        //如果是滑动的话，禁止代理方法
        isForbitScrollDelegate = true
        
        let offsetX = CGFloat(index) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x:offsetX,y:0), animated: false)
        
    }
}
