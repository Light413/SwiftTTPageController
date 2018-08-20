# SwiftTTPageController 
仿网易新闻、头条等首页列表切换效果
>Swift 3.0+ ,Xcode8.0 +
>
>实现多个ViewController列表切换；
>
>效果如下：

![TTTagListController](https://github.com/Light413/DemoSwift_TTTagListController/blob/master/2018-07-24%2009_48_10.gif?raw=true)


## 安装

```
pod 'SwiftTTPageController'
```

## 应用

* 创建HeadView

```
let titles = ["新闻","视频","最新","新闻","视频","最新","军事","头条"]
        
let headView = TTHeadView (frame: CGRect (x: 0, y: 0, width: UIScreen.main.bounds.width, height: 30), titles: titles, delegate: self)
        
navigationItem.titleView = headView;
        
```

* 创建列表控制器，并添加到父控制器之上

```
let vcs = [TableViewController(),TableViewController(),TableViewController(),TableViewController(),TableViewController(),TableViewController(),TableViewController(),TableViewController(),]
        
let frame = CGRect (x: 0, y: 0, width: view.frame.width, height: view.frame.height)

let pagevc = TTPageViewController.init(controllers: vcs, frame: frame, delegate: self)
        
self.addChildViewController(pagevc)
self.view.addSubview(pagevc.view)
        
```

* 遵守协议`TTHeadViewDelegate,TTPageViewControllerDelegate ` 实现代理方法，处理事件

```
    /////Delegate methods
    func tt_headViewSelectedAt(_ index: Int) {
        pagevc.scrollToPageAtIndex(index)
    }
    
    func tt_pageControllerSelectedAt(_ index: Int) {
        headView.scrollToItemAtIndex(index)
    }

```

## License

See LICENSE file for details

