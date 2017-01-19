//
//  MainViewController.swift
//  SWZB
//
//  Created by jiaerdong on 2017/1/19.
//  Copyright © 2017年 springwoods. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        addChildVc("Home")
        addChildVc("Live")
        addChildVc("Follow")
        addChildVc("Discovery")
        addChildVc("Profile")
        
    }
    
    private func addChildVc(storyboardName: String){
        let childVc = UIStoryboard(name: storyboardName, bundle: nil).instantiateInitialViewController()!
        childVc.view.backgroundColor = UIColor.blueColor()
        addChildViewController(childVc)
    }

}
