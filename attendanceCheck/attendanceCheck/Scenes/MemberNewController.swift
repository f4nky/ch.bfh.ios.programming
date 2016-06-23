//
//  MemberNewController.swift
//  attendanceCheck
//
//  Created by Fanky on 23.06.16.
//  Copyright © 2016 Fanky. All rights reserved.
//

import UIKit

class MemberNewController: UITableViewController {

    @IBOutlet var memberTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        memberTableView.delegate = self
        memberTableView.dataSource = self
        //memberTableView.separatorInset = UIEdgeInsetsZero
        //memberTableView.layoutMargins = UIEdgeInsetsZero
        memberTableView.rowHeight = 50.0
    }
}
