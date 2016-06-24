//
//  EventNewController.swift
//  attendanceCheck
//
//  Created by Fanky on 23.06.16.
//  Copyright © 2016 Fanky. All rights reserved.
//

import UIKit

class EventNewController: UITableViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet var eventTableView: UITableView!
    @IBOutlet weak var eventDatePicker: UIDatePicker!
    @IBOutlet weak var eventTypePicker: UIPickerView!
    @IBOutlet weak var txtEventDesc: UITextField!
    
    var event: Event?
    var eventTypes = [EventType]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        eventTableView.delegate = self
        eventTableView.dataSource = self
        eventTableView.separatorInset = UIEdgeInsetsZero
        eventTableView.layoutMargins = UIEdgeInsetsZero
        eventTableView.rowHeight = 50.0
        
        eventTypePicker.delegate = self
        eventTypePicker.dataSource = self
        
        loadEventTypeData()
        
        self.navigationController!.navigationBar.tintColor = UIColor.whiteColor();
    }
    
    func loadEventTypeData() {
        EventTypeApi.getEventTypes() {eventTypes in
            self.eventTypes = eventTypes
            dispatch_async(dispatch_get_main_queue()) {
                self.eventTypePicker.reloadAllComponents()
            }
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if (indexPath.section == 0 || indexPath.section == 1) {
            return 100
        }
        return self.tableView.rowHeight
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return eventTypes.count;
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return eventTypes[row].name
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "saveEventDetails" {
            let eventDate = eventDatePicker.date
            let eventType = eventTypes[eventTypePicker.selectedRowInComponent(0)]
            let eventDesc = txtEventDesc.text
            event = Event(id: nil, date: eventDate, description: eventDesc, eventType: eventType)
        }
    }
}
