//
//  DetailViewController.swift
//  attendanceCheck
//
//  Created by Fanky on 29.03.16.
//  Copyright © 2016 Fanky. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var memberTableView: UITableView!

    var sections = ["Trainer", "Spielerin"]
    var members = [[
            Member(firstName: "Max", lastName: "Mustermann", birthDate: nil),
            Member(firstName: "Felix", lastName: "Muster", birthDate: nil)
        ], [
            Member(firstName: "Anna", lastName: "Schweizer", birthDate: nil),
            Member(firstName: "Erika", lastName: "Musterfrau", birthDate: nil),
            Member(firstName: "Jane", lastName: "Doe", birthDate: nil)
        ]
    ]
    
    var detailItem: AnyObject? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    func configureView() {
        // Update the user interface for the detail item.
        /*if let detail = self.detailItem {
            if let label = self.detailDescriptionLabel {
                label.text = detail.description
            }
        }*/
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nibHeaderCell = UINib(nibName: "vwMemberHeaderCell", bundle: nil)
        memberTableView.registerNib(nibHeaderCell, forCellReuseIdentifier: "memberHeaderCell")
        
        memberTableView.sectionHeaderHeight = 20.0
        
        let nibMemberCell = UINib(nibName: "vwMemberCell", bundle: nil)
        memberTableView.registerNib(nibMemberCell, forCellReuseIdentifier: "memberCell")
        
        memberTableView.delegate = self
        memberTableView.dataSource = self
        memberTableView.separatorInset = UIEdgeInsetsZero
        memberTableView.layoutMargins = UIEdgeInsetsZero
        memberTableView.rowHeight = 50.0
        
        self.configureView()
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return sections.count
        //return 1
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerCell = tableView.dequeueReusableCellWithIdentifier("memberHeaderCell") as! MemberHeaderCell
        
        headerCell.lblTitle!.text = sections[section].uppercaseString
        
        return headerCell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return members[section].count
        //return members.count
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.separatorInset = UIEdgeInsetsZero
        cell.layoutMargins = UIEdgeInsetsZero
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("memberCell", forIndexPath: indexPath) as! MemberCell
        
        let member = members[indexPath.section][indexPath.row]
        //let member = members[indexPath.row]
        cell.lblMemberName.text = member.firstName!.uppercaseString + " " + member.lastName!.uppercaseString
        return cell
    }
}

