//
//  HomeViewController.swift
//  SWZB
//
//  Created by jiaerdong on 2017/1/19.
//  Copyright © 2017年 springwoods. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }

}



// mark： 设置界面UI
extension HomeViewController {
    
    private func setupUI(){
        setupNavgrationBar()
        
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