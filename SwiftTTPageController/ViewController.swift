//
//  ViewController.swift
//  SwiftTTPageController
//
//  Created by gener on 2018/8/8.
//  Copyright © 2018年 Light. All rights reserved.
//

import UIKit

class ViewController: UIViewController,TTHeadViewDelegate,TTPageViewControllerDelegate {
    
    var headView:TTHeadView!
    var pagevc:TTPageViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var attri = TTHeadTextAttribute()
        attri.needBottomLine = true
        
        //创建headView
        let titles = ["新闻","视频","最新","新闻","视频","最新","军事","头条"]
        headView = TTHeadView (frame: CGRect (x: 0, y: 0, width: UIScreen.main.bounds.width, height: 35), titles: titles, delegate: self ,textAttributes:attri)
        
        navigationItem.titleView = headView;
        
        //创建TTPageViewController
        let vcs = [TableViewController(),TableViewController(),TableViewController(),TableViewController(),TableViewController(),TableViewController(),TableViewController(),TableViewController(),]
        
        let frame = CGRect (x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        pagevc = TTPageViewController.init(controllers: vcs, frame: frame, delegate: self)
        
        //添加到当前控制器视图
        self.addChild(pagevc)
        self.view.addSubview(pagevc.view)
        
    }
    
    /////Delegate methods
    func tt_headViewSelectedAt(_ index: Int) {
        pagevc.scrollToPageAtIndex(index)
    }
    
    func tt_pageControllerSelectedAt(_ index: Int) {
        headView.scrollToItemAtIndex(index)
    }
    
}

