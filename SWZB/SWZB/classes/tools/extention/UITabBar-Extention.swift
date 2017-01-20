//
//  UITabBar-Extention.swift
//  SWZB
//
//  Created by jiaerdong on 2017/1/19.
//  Copyright © 2017年 springwoods. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    
    //类方法创建
    class func createItem(imageName: String, highImageName: String, size:CGSize) -> UIBarButtonItem  {
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), forState: .Normal)
        btn.setImage(UIImage(named: highImageName), forState: .Highlighted)
        btn.frame = CGRect(origin: CGPointZero, size: size)
        
        return UIBarButtonItem(customView: btn)
    }
    
    
    //1 便利构造方法convenience 2 必须调用自身的构造方法
    convenience init(imageName: String, highImageName: String = "", size:CGSize = CGSizeZero) {
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), forState: .Normal)
        if(highImageName != ""){
            btn.setImage(UIImage(named: highImageName), forState: .Highlighted)
        }
        
        if(size == CGSizeZero){
            btn.sizeToFit()
        }else{
            btn.frame = CGRect(origin: CGPointZero, size: size)
        }
        
        
        self.init(customView: btn)
    }
    
    
}
