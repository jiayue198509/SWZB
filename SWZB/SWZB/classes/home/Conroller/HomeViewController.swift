//
//  HomeViewController.swift
//  SWZB
//
//  Created by jiaerdong on 2017/1/19.
//  Copyright © 2017年 springwoods. All rights reserved.
//

import UIKit

private let kTitleViewH: CGFloat = 40

class HomeViewController: UIViewController {
    
    private lazy var pageTitleView: PageTitleView = { [weak self] in
        let titleFrame = CGRect(x: 0, y: kStatusBarH + kNavgrationBarH, width: kScreenW, height: kTitleViewH)
        let titles = ["推荐", "手游", "娱乐", "游戏", "趣玩"]
        let titleView = PageTitleView(frame: titleFrame, titles: titles)
        titleView.deglate = self
        return titleView
    
    }()
    
    
    
    private lazy var pageContentView: PageContentView = { [weak self] in
        
        //确定内容frame
        let frame = CGRect(x: 0, y: kStatusBarH + kNavgrationBarH + kTitleViewH, width: kScreenW, height: kScreenH - kStatusBarH - kNavgrationBarH - kTitleViewH)
        
        var childVcs:[UIViewController] = [UIViewController]()
        //确定所有子控制器
        for _ in 0 ..< 5 {
            let viewController = UIViewController()
            viewController.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            childVcs.append(viewController)
        }
        
        let pageContentView = PageContentView(frame: frame, childVcs: childVcs, parentViewController: self)
        pageContentView.delegate = self
        return pageContentView
    }()
    
    //系统会掉函数
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }

}



// mark： 设置界面UI
extension HomeViewController {
    
    private func setupUI(){
        //不调整scrollowview 那边距
        automaticallyAdjustsScrollViewInsets = false
        setupNavgrationBar()
        
        //设置titleview
        setupPageTitleView()
        
        setupPageContentView()
        

        
    }
    
    //设置pagecontentview
    private func setupPageContentView() {
        self.view.addSubview(pageContentView)
    }
    
    private func setupPageTitleView(){
        self.view.addSubview(pageTitleView)
    }
    
//    设置导航栏
    private func setupNavgrationBar() {
        
//        let leftItem = UIButton()
//        leftItem.setImage(UIImage(named: "homeLogoIcon"), forState: UIControlState.Normal)
//        leftItem.sizeToFit()
//        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftItem)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "homeLogoIcon")
        
//        let size = CGSize(width: 40, height: 40)
//        let scanItem = UIButton()
//        scanItem.setImage(UIImage(named: "scanIcon"), forState: UIControlState.Normal)
//        scanItem.frame = CGRect(origin: CGPoint.zero, size: size)
//
//        let searchItem = UIButton()
//        searchItem.setImage(UIImage(named: "searchBtnIcon"), forState: UIControlState.Normal)
//        searchItem.frame = CGRect(origin: CGPoint.zero, size: size)
//        
//        
//        let historyItem = UIButton()
//        historyItem.setImage(UIImage(named: "viewHistoryIcon"), forState: UIControlState.Normal)
//        historyItem.frame = CGRect(origin: CGPoint.zero, size: size)
        
//        let size = CGSize(width: 40, height: 40)
//        let searchBtn = UIBarButtonItem.createItem("searchBtnIcon", highImageName: "searchBtnIconHL", size: size)
//        let scanBtn = UIBarButtonItem.createItem("scanIcon", highImageName: "scanIconHL", size: size)
//        let historyBtn = UIBarButtonItem.createItem("viewHistoryIcon", highImageName: "viewHistoryIconHL", size: size)
        
        let size = CGSize(width: 40, height: 40)
        let searchBtn = UIBarButtonItem(imageName: "searchBtnIcon", highImageName: "searchBtnIconHL", size: size)
        let scanBtn = UIBarButtonItem(imageName: "scanIcon", highImageName: "scanIconHL", size: size)
        let historyBtn = UIBarButtonItem(imageName: "viewHistoryIcon", highImageName: "viewHistoryIconHL", size: size)
        
//        
        self.navigationItem.rightBarButtonItems = [searchBtn, scanBtn, historyBtn]
        
        
    }
}

extension HomeViewController: PageTitleViewDegelate {
    func pageTitleView(pageTitleView: PageTitleView, selectIndex index: Int) {
        pageContentView.setCurrentIndex(index)
    }
}

extension HomeViewController: PageContentViewDelegate {
    func pageContentView(pageContentView: PageContentView, progreess: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView.setTitleViewWithProgress(progreess, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}