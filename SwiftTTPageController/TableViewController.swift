//
//  TableViewController.swift
//  SwiftTTPageController
//
//  Created by gener on 2018/8/8.
//  Copyright © 2018年 Light. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    let _colors:[UIColor] = [UIColor.red,
                             UIColor.blue,
                             UIColor.orange,
                             UIColor.cyan,
                             UIColor.yellow,
                             UIColor.green]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let i:Int = Int.init(arc4random()%6)
        
        view.backgroundColor = _colors[i]
        tableView.tableFooterView = UIView()
    }
    
    
}
