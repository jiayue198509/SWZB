//
//  UIColor-Extentions.swift
//  SWZB
//
//  Created by jiaerdong on 2017/1/20.
//  Copyright © 2017年 springwoods. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1.0)
    }
}
