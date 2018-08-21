//
//  TTHeadView.swift
//  SwiftTTPageController
//
//  Created by gener on 2018/8/8.
//  Copyright © 2018年 Light. All rights reserved.
//

import UIKit

public protocol TTHeadViewDelegate {
    func tt_headViewSelectedAt(_ index:Int);
}

public struct TTHeadTextAttribute {
    public var defaultTextColor:UIColor = UIColor.darkGray
    public var defaultFontSize:CGFloat = 15
    
    public var selectedTextColor:UIColor = UIColor.black
    public var selectedFontSize:CGFloat = 16
    
    public var bottomLineColor:UIColor = UIColor.orange
    
    public var itemWidth:CGFloat = 50 //itemSize
    
    public init() {
        
    }
}


open class TTHeadView: UIView {
    /*textAttribute*/
    var textAttribute:TTHeadTextAttribute!
    
    fileprivate var _titles :[String]!
    fileprivate var _currentIndex: Int = 0//current selected
    fileprivate var _delegate:TTHeadViewDelegate?
    
    fileprivate var _collectionView:UICollectionView!
    fileprivate let _locationWidth:CGFloat = 20
    fileprivate var _bottomLine:UILabel!
    
    //MARK: - Init
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        _collectionView = colleciontView(CGRect (x: 0, y: 0, width: frame.width, height: frame.height))
        self.addSubview(_collectionView)
    }
    
   public init(frame:CGRect,titles:[String],delegate:TTHeadViewDelegate? = nil, textAttributes:TTHeadTextAttribute = TTHeadTextAttribute()) {
        super.init(frame:frame)
    
        _titles = titles
        _delegate = delegate
        textAttribute = textAttributes
    
        _collectionView = colleciontView(CGRect (x: 0, y: 0, width: frame.width, height: frame.height))
        self.addSubview(_collectionView)
        
        //location line
        _bottomLine = UILabel (frame: CGRect (x: (textAttribute.itemWidth - _locationWidth)/2, y: _collectionView.frame.height - 3, width: _locationWidth, height: 3))
        _bottomLine.backgroundColor = textAttribute.bottomLineColor
    
        _bottomLine.layer.cornerRadius = 2
        _bottomLine.layer.masksToBounds = true
        _collectionView.addSubview(_bottomLine)
    }
    
    //MARK: -
    /// scroll to specific index location
    ///
    /// - parameter index:
    public func scrollToItemAtIndex(_ index:Int) {
        _currentIndex = index
        _collectionView.reloadData()
        
        let item_width = (_collectionView.collectionViewLayout as! UICollectionViewFlowLayout).itemSize.width
        var offset = item_width * (CGFloat(index) + 0.5) - _collectionView.frame.width / 2
        let max = _collectionView.contentSize.width - _collectionView.frame.width + _collectionView.contentInset.left
        
        if offset < 0 { offset = -_collectionView.contentInset.left;}
        if offset > 0 && max > 0 && offset > max { offset = max;}
        
        let _x = CGFloat.init(index) * textAttribute.itemWidth + (item_width - 0) * 0.5
        
        UIView.animate(withDuration: 0.2) {[unowned self] in
            self._bottomLine.center = CGPoint (x: _x, y: self._bottomLine.center.y);
        }
        
        
        //...
        guard CGFloat.init(_titles.count) * textAttribute.itemWidth > self.frame.width else {return }
        _collectionView.setContentOffset(CGPoint (x: offset, y: 0), animated: true)
    }
    
    fileprivate func colleciontView(_ frame:CGRect) -> UICollectionView {
        let _layout = UICollectionViewFlowLayout()
        _layout.itemSize = CGSize (width: textAttribute.itemWidth, height: frame.height)
        _layout.minimumInteritemSpacing = 0
        _layout.minimumLineSpacing = 0
        _layout.scrollDirection = .horizontal
        
        let collectionview = UICollectionView (frame: frame, collectionViewLayout: _layout)
        collectionview.delegate  = self
        collectionview.dataSource = self
        collectionview.register(UICollectionViewCell.self, forCellWithReuseIdentifier: String (describing: UICollectionViewCell.self))
        collectionview.showsHorizontalScrollIndicator = false
        collectionview.showsVerticalScrollIndicator = false
        collectionview.backgroundView = nil
        collectionview.backgroundColor = UIColor.white
        return collectionview
    }
    
}

//MARK: - UICollectionViewDataSource
extension TTHeadView:UICollectionViewDelegate,UICollectionViewDataSource {

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return _titles.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String (describing: UICollectionViewCell.self), for: indexPath)
        let v = _titles[indexPath.row]
        
        for _v in cell.contentView.subviews{
            _v.removeFromSuperview();
        }
        
        let l = UILabel.init(frame: CGRect (x: 0, y: 0, width: textAttribute.itemWidth, height: self.frame.height))
        l.font = UIFont.systemFont(ofSize: _currentIndex == indexPath.row ? textAttribute.selectedFontSize:textAttribute.defaultFontSize, weight: UIFontWeightRegular)
        l.textAlignment = .center
        l.text = v
        l.textColor = _currentIndex == indexPath.row ? textAttribute.selectedTextColor:textAttribute.defaultTextColor
        
        cell.contentView.addSubview(l)
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let index = indexPath.row
        guard index != _currentIndex else{ return }
        _currentIndex = index
        collectionView.reloadData()
        
        scrollToItemAtIndex(index)
        
        if let delegate = _delegate {
            delegate.tt_headViewSelectedAt(index)
        }
    }
    
}
