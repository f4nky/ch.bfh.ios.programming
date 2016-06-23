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
    
    var sections = ["April"]
    var events = [Event]()
    
    var detailViewController: DetailViewController? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.refreshControl?.addTarget(self, action: #selector(MasterViewController.refresh(_:)), forControlEvents: UIControlEvents.ValueChanged)
        
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
        
        loadAttendanceData()
        
        let initialIndexPath = NSIndexPath(forRow: 0, inSection: 0)
        self.eventTableView.selectRowAtIndexPath(initialIndexPath, animated: true, scrollPosition:UITableViewScrollPosition.None)
        
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
            self.performSegueWithIdentifier("showDetail", sender: initialIndexPath)
        }
    }
    
    func refresh(sender:AnyObject) {
        loadAttendanceData()
        self.refreshControl?.endRefreshing()
    }
    
    func loadAttendanceData() {
        EventApi.getEvents() {events in
            self.events = events
            dispatch_async(dispatch_get_main_queue()) {
                self.tableView.reloadData()
            }
        }
    }

    override func viewWillAppear(animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Segues

    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print(segue.identifier)
        if segue.identifier == "showDetail" {
            
            //if let indexPath = self.eventTableView.indexPathForSelectedRow {
            if let indexPath = self.eventTableView.indexPathForCell(sender as! UITableViewCell) {
                print(indexPath)
                let event = events[indexPath.row]
                print(event)
                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
                controller.event = event
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
            } else {
                print("blub")
            }
        }
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        //return sections.count
        return 1
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        performSegueWithIdentifier("showDetail", sender: cell)
    }
    
    /*override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }

    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerCell = tableView.dequeueReusableCellWithIdentifier("defaultHeaderCell") as! DefaultHeaderCell
        
        headerCell.lblTitle!.text = sections[section].uppercaseString
        
        return headerCell
    }*/
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return events[section].count
        return events.count
    }

    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.separatorInset = UIEdgeInsetsZero
        cell.layoutMargins = UIEdgeInsetsZero
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("eventCell", forIndexPath: indexPath) as! EventCell
        
        //let event = events[indexPath.section][indexPath.row] as Event
        let event = events[indexPath.row] as Event
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "EE, dd.MM.yyyy"
        
        cell.lblEventType!.text = event.eventType?.abbr
        cell.lblEventDate!.text = dateFormatter.stringFromDate(event.date!)
        cell.lblEventInfo!.text = event.desc
        
        return cell
    }
}

