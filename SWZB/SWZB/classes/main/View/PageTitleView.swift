//
//  PageTitleView.swift
//  SWZB
//
//  Created by jiaerdong on 2017/1/20.
//  Copyright © 2017年 springwoods. All rights reserved.
//

import UIKit

protocol  PageTitleViewDegelate:class {
    func pageTitleView(pageTitleView: PageTitleView, selectIndex index: Int)
}

//定义常量
private let kScrollLineH: CGFloat = 2
private let kNormalColor: (CGFloat, CGFloat, CGFloat) = (92,92,92)
private let kSelectColor: (CGFloat, CGFloat, CGFloat ) = (255,128,37)

class PageTitleView: UIView {
    
    
    private var currentIndex:Int = 0
    //定义属性
    private var titles:[String]
    
    weak var deglate: PageTitleViewDegelate?

    
    private lazy var titileLabels: [UILabel] = [UILabel]()
    
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.showsHorizontalScrollIndicator = false
        //点击状态栏返回东部关闭
        scroll.scrollsToTop = false
        //当scrollview滚动到边界时，再继续滚动会有个反弹的效果，scrollview里有bounce属性，当设置为yes时，可以反弹，设置为NO时不能反弹
        scroll.bounces = false
        return scroll
        
    }()
    
    private lazy var scrollLine:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.orangeColor()
        return view
    }()
    
    //自定义构造函数
    init(frame: CGRect, titles: [String]) {
        self.titles = titles
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


//设置ui
extension PageTitleView {
    
    private func setupUI(){
        setupScrollView()
        setupTitleLabels()
        
        //设置底线和滑块
        setupBottomLineAndScrollLine()
    }
    
    
    private func setupBottomLineAndScrollLine(){
        let bottom = UIView()
        bottom.backgroundColor = UIColor.grayColor()
        let lineH: CGFloat = 0.5
        bottom.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
        addSubview(bottom)
        scrollView.addSubview(scrollLine)
        
        //添加scrollLine
        guard let first = titileLabels.first else { return }
        first.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        scrollLine.frame = CGRect(x: first.frame.origin.x, y: frame.height - kScrollLineH, width: first.bounds.width, height: kScrollLineH)
        
    }
    
    private func setupScrollView(){
        addSubview(scrollView)
        scrollView.frame = bounds
    }
    
    private func setupTitleLabels(){
        
        let labelW: CGFloat = frame.width / CGFloat(titles.count)
        let labelH: CGFloat = frame.height - kScrollLineH
        let labelY: CGFloat = 0
        
        for (index, title) in titles.enumerate() {
            let label = UILabel()
            label.text = title
            label.tag = index
            label.textColor = UIColor.darkGrayColor()
            label.textAlignment = .Center
            label.font = UIFont.boldSystemFontOfSize(16.0)
            
            //设置frame属性
            let labelX: CGFloat = labelW * CGFloat(index)

            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            scrollView.addSubview(label)
            titileLabels.append(label)
            
            //添加点击事件响应首饰
            label.userInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(self.titlelabelClick(_:)))
            
            label.addGestureRecognizer(tapGes)
        }
    }
}

//事件监听
extension PageTitleView {
    func titlelabelClick(tapGes: UITapGestureRecognizer) {
        //获取当前label的下标志
        guard let currentLabel = tapGes.view as? UILabel else  { return }
        currentLabel.textColor = UIColor.orangeColor()
        let oldlabel = titileLabels[currentIndex]
        oldlabel.textColor = UIColor.darkGrayColor()
        currentIndex = currentLabel.tag
        
        //滚动条位置改变
        let scrollPositionX = CGFloat(currentIndex) * scrollLine.frame.width
        UIView.animateWithDuration(
            0.2) { 
                self.scrollLine.frame.origin.x = scrollPositionX
        }
        
        deglate?.pageTitleView(self, selectIndex: currentIndex)
        
    }
}

//暴露的接口
extension PageTitleView {
    func setTitleViewWithProgress(progress: CGFloat, sourceIndex:Int,targetIndex:Int) {
        let sourceLabel = titileLabels[sourceIndex]
        let targetlabel = titileLabels[targetIndex]
        
        //渐变处理
        let colorDelta = (kSelectColor.0 - kNormalColor.0, kSelectColor.1 - kNormalColor.1, kSelectColor.2 - kNormalColor.2)
        
        sourceLabel.textColor = UIColor(r: kSelectColor.0 - colorDelta.0 * progress, g: kSelectColor.1 - colorDelta.1 * progress, b: kSelectColor.2 - colorDelta.2 * progress)
        
        targetlabel.textColor = UIColor(r: kNormalColor.0 + colorDelta.0 * progress, g: kNormalColor.1 + colorDelta.1 * progress, b: kNormalColor.2 + colorDelta.2 * progress)
        
        
        //滑块逻辑处理
        let moveTotalX = targetlabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveX = moveTotalX * progress
        scrollLine.frame.origin.x = moveX + sourceLabel.frame.origin.x
        currentIndex = targetIndex
    }
}
