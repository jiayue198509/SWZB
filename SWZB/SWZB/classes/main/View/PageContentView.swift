//
//  PageContentView.swift
//  SWZB
//
//  Created by jiaerdong on 2017/1/20.
//  Copyright © 2017年 springwoods. All rights reserved.
//

import UIKit

protocol PageContentViewDelegate: class {
    func pageContentView(pageContentView: PageContentView, progreess:CGFloat, sourceIndex:Int, targetIndex: Int)
}

private let ContentViewID = "ContentViewID"
class PageContentView: UIView {
    
    private var startOffsetX: CGFloat = 0
    private var childVcs: [UIViewController]
    private weak var parentViewController:UIViewController?
    private var isForbidScroll: Bool = false
    weak var delegate:PageContentViewDelegate?
    private lazy var collectionView:UICollectionView = { [weak self] in
        
        //流水布局
        let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .Horizontal

        let collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.pagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentViewID)
        
        return collectionView
    }()

    init(frame: CGRect, childVcs: [UIViewController], parentViewController: UIViewController? ) {
        
        self.childVcs = childVcs
        self.parentViewController = parentViewController
        super.init(frame: frame)
        
        //设置UI
        setupUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

//设置UI
extension PageContentView {
    private func setupUI(){
        
        for childVc in childVcs {
            parentViewController?.addChildViewController(childVc)
        }
        
        //添加UICollectionView，用于在cell中存放控制器的view
        addSubview(collectionView)
        collectionView.frame = bounds
    }
}


//遵守collectionview datasource协议
extension PageContentView: UICollectionViewDataSource{
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        //创建cell
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(ContentViewID, forIndexPath: indexPath)
        
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        
        let childVc = childVcs[indexPath.item]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
    
        return cell
    }
    
}
extension PageContentView: UICollectionViewDelegate {
    
    //开始拖拽
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        //记录起始偏移量
        startOffsetX = scrollView.contentOffset.x
    }
    
    //滚动完成
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if isForbidScroll { return }
        //记录滑动进度
        var progress: CGFloat = 0
        var sourceIndex: Int = 0
        var targetIndex: Int = 0
        
        let offsetX = scrollView.contentOffset.x
        let scrollW = scrollView.bounds.width
        if offsetX >= startOffsetX { //左滑
            //计算进度
            progress = offsetX/scrollW - floor(offsetX/scrollW)
            //计算sourceIndex
            sourceIndex = Int(offsetX/scrollW)
            //计算targetIndex
            targetIndex = sourceIndex + 1
            if targetIndex >= childVcs.count {
                targetIndex = childVcs.count - 1
            }
            
            if offsetX - startOffsetX == scrollW {
                progress = 1.0
                targetIndex = sourceIndex
            }
            
        } else { //右滑
            //计算进度
            progress = 1 - (offsetX / scrollW - floor(offsetX / scrollW))
            //计算sourceIndex
            targetIndex = Int(offsetX / scrollW)
            //计算targetIndex
            sourceIndex = targetIndex + 1
            if targetIndex >= childVcs.count {
                targetIndex = childVcs.count - 1
            }
        }
        
        delegate?.pageContentView(self, progreess: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
        print("progress=\(progress) sourceIndex=\(sourceIndex) targetIndex=\(targetIndex)")
        
        
    }
}

//对外暴露的方法
extension PageContentView {
    func setCurrentIndex(currentIndex: Int) {
        //
        isForbidScroll = true
        let offsetX = CGFloat(currentIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x:offsetX, y:0), animated: false)
    }
}
