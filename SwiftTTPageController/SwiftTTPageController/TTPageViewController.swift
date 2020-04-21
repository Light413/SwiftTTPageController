//
//  TTPageViewController.swift
//  SwiftTTPageController
//
//  Created by gener on 2018/8/8.
//  Copyright © 2018年 Light. All rights reserved.
//

import UIKit

@objc public protocol TTPageViewControllerDelegate {
    func tt_pageControllerSelectedAt(_ index:Int)
}

open class TTPageViewController: UIViewController {
    
    public var _viewControllers :[UIViewController]!
    
    var currentIndex: Int = 0//current selected index
    
    weak var _delegate:TTPageViewControllerDelegate?
    
    var _collectionView:UICollectionView!
    
    //MARK: -
    override open func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = .top
    }
    
    override open func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        _collectionView = self.colleciontView()
        view.addSubview(_collectionView)
    }
    
   public init(controllers:[UIViewController], frame viewFrame:CGRect,delegate:TTPageViewControllerDelegate? = nil) {
        super.init(nibName: nil, bundle: nil)
        
        _viewControllers = controllers
        _delegate = delegate
        view.frame = viewFrame
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    fileprivate func colleciontView() -> UICollectionView {
        let rect = CGRect (x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        let _layout = UICollectionViewFlowLayout()
        _layout.itemSize = rect.size
        _layout.minimumInteritemSpacing = 0
        _layout.minimumLineSpacing = 0
        _layout.scrollDirection = .horizontal
        
        let collectionview = UICollectionView (frame: rect, collectionViewLayout: _layout)
        collectionview.delegate  = self
        collectionview.dataSource = self
        collectionview.register(UICollectionViewCell.self, forCellWithReuseIdentifier: String (describing: UICollectionViewCell.self))
        collectionview.backgroundColor  = UIColor.white
        collectionview.isPagingEnabled = true
        collectionview.showsHorizontalScrollIndicator = false
        collectionview.showsVerticalScrollIndicator = false
        return collectionview
    }
   
    //Public Method
   public func scrollToPageAtIndex(_ index:Int) {
        _collectionView.scrollToItem(at: IndexPath.init(row: index, section: 0), at: .right, animated: false)
    }
    
}





extension TTPageViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    //MARK: - UICollectionViewDataSource
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return _viewControllers.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String (describing: UICollectionViewCell.self), for: indexPath)
        let v = _viewControllers[indexPath.row]
        for _v in cell.contentView.subviews{
            _v.removeFromSuperview();
            
        }
        
        v.removeFromParent()
        v.view.frame =  CGRect (x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        
        self.addChild(v)
        cell.contentView.addSubview(v.view)
        return cell
    }
    
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        _scroll(scrollView);
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        _scroll(scrollView);
    }
    
    func _scroll(_ scrollView: UIScrollView) {
        let index = scrollView.contentOffset.x / scrollView.frame.width
        let i = lrintf(Float(index))
        guard i != currentIndex else{ return }
        currentIndex = i
        
        if let delegate = _delegate {
            delegate.tt_pageControllerSelectedAt(i)
        }
    }
    
}
