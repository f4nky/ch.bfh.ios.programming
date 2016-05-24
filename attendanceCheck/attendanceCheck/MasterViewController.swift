//
//  MasterViewController.swift
//  attendanceCheck
//
//  Created by Fanky on 29.03.16.
//  Copyright © 2016 Fanky. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    
    @IBOutlet var eventTableView: UITableView!
    
    var sections = ["April", "Mai"]
    var events = [[
            Event(date: "2016-04-25", desc: "18.20 - 20.00"),
            Event(date: "2016-04-29", desc: "18.20 - 20.00"),
            Event(date: "2016-05-02", desc: "18.20 - 20.00")
        ], []
    ]
    
    var detailViewController: DetailViewController? = nil
    //var manager: RestManager! = RestManager()
    //var members = [Member]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.leftBarButtonItem = self.editButtonItem()

        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertNewObject:")
        self.navigationItem.rightBarButtonItem = addButton
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
        
        let nibHeaderCell = UINib(nibName: "vwDefaultHeaderCell", bundle: nil)
        eventTableView.registerNib(nibHeaderCell, forCellReuseIdentifier: "defaultHeaderCell")
        
        eventTableView.sectionHeaderHeight = 20.0
        
        let nibEventCell = UINib(nibName: "vwEventCell", bundle: nil)
        eventTableView.registerNib(nibEventCell, forCellReuseIdentifier: "eventCell")
        
        eventTableView.delegate = self
        eventTableView.dataSource = self
        eventTableView.separatorInset = UIEdgeInsetsZero
        eventTableView.layoutMargins = UIEdgeInsetsZero
        eventTableView.rowHeight = 50.0
    }

    override func viewWillAppear(animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
        super.viewWillAppear(animated)
        /*self.manager.getMembers() {members in
            //print(members)
            self.members = members
            dispatch_async(dispatch_get_main_queue()) { () -> Void in
                self.memberTableView.reloadData()
            }
        }*/
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let event = events[indexPath.row]
                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = event
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return sections.count
        //return 1
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }

    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerCell = tableView.dequeueReusableCellWithIdentifier("defaultHeaderCell") as! DefaultHeaderCell
        
        headerCell.lblTitle!.text = sections[section].uppercaseString
        
        return headerCell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events[section].count
        //return members.count
    }

    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.separatorInset = UIEdgeInsetsZero
        cell.layoutMargins = UIEdgeInsetsZero
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("eventCell", forIndexPath: indexPath) as! EventCell
        
        let event = events[indexPath.section][indexPath.row] as Event
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "EE, dd.MM.yyyy"
        
        cell.lblEventType!.text = "Tr"
        cell.lblEventDate!.text = dateFormatter.stringFromDate(event.date!)
        cell.lblEventInfo!.text = event.desc
        
        return cell
    }
}

