//
//  EventController.swift
//  attendanceCheck
//
//  Created by Fanky on 21.06.16.
//  Copyright © 2016 Fanky. All rights reserved.
//

import UIKit

class EventController: UITableViewController {

    @IBOutlet var eventTableView: UITableView!
    
    @IBAction func cancelToList(segue: UIStoryboardSegue) {
        
    }
    @IBAction func saveEvent(segue: UIStoryboardSegue) {
        if let eventDetailsController = segue.sourceViewController as? EventNewController {
            if let event = eventDetailsController.event {
                EventApi.saveEvent(event) {_ in}
                loadEventData()
            }
        }
    }
    
    var events = [Event]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.refreshControl?.addTarget(self, action: #selector(EventController.refresh(_:)), forControlEvents: UIControlEvents.ValueChanged)
        
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
    
        loadEventData()
    }
    
    func refresh(sender:AnyObject) {
        loadEventData()
        self.refreshControl?.endRefreshing()
    }
    
    func loadEventData() {
        EventApi.getEvents() {events in
            self.events = events
            dispatch_async(dispatch_get_main_queue()) {
                self.tableView.reloadData()
            }
        }
    }
    
    func deleteEvent(id: Int) {
        EventApi.deleteEvent(id) {_ in}
        loadEventData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }

    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.separatorInset = UIEdgeInsetsZero
        cell.layoutMargins = UIEdgeInsetsZero
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("eventCell", forIndexPath: indexPath) as! EventCell
        
        let event = events[indexPath.row] as Event
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "EE, dd.MM.yyyy"
        
        cell.accessoryType = UITableViewCellAccessoryType.None
        cell.lblEventType!.text = event.eventType?.abbr
        cell.lblEventDate!.text = dateFormatter.stringFromDate(event.date!)
        cell.lblEventInfo!.text = event.description
        
        return cell
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            let event = events[indexPath.row]
            deleteEvent(event.id!)
            loadEventData()
        }
    }

}
