//
//  ViewController.swift
//  HeadScrollViewTest
//
//  Created by gener on 2018/7/23.
//  Copyright © 2018年 Light. All rights reserved.
//

import UIKit

class ViewController: UIViewController,TTHeadTitleDelegate,TTPageViewControllerDelegate {

    var headView:TTHeadTitleView!
    var pagevc:TTPageViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let titles = ["新闻","视频","最新","新闻","视频","最新","军事","头条"]
        headView = TTHeadTitleView (frame: CGRect (x: 0, y: 0, width: UIScreen.main.bounds.width, height: 30), titles: titles, delegate: self)
        navigationItem.titleView = headView;
        
        let vcs = [TableViewController(),TableViewController(),TableViewController(),TableViewController(),TableViewController(),TableViewController(),TableViewController(),TableViewController(),]
        
        let frame = CGRect (x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        pagevc = TTPageViewController.init(controllers: vcs, frame: frame, delegate: self)

        self.addChildViewController(pagevc)
        self.view.addSubview(pagevc.view)

    }

    /////Delegate methods
    func titleClickedAtIndex(_ index: Int) {
        pagevc.scrollToPageAtIndex(index)
    }
    
    func pageViewControllerScrollTo(_ index: Int) {
        headView.scrollToItemAtIndex(index)
    }
    
}

