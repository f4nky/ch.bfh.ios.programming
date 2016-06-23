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
    
    @IBAction func cancelToList(segue: UIStoryboardSegue) {
        print("cancel")
    }
    @IBAction func saveEvent(segue: UIStoryboardSegue) {
        print("save")
    }
    
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
    }
    
    func loadEventTypeData() {
        EventTypeApi.getEventTypes() {eventTypes in
            self.eventTypes = eventTypes
            /*dispatch_async(dispatch_get_main_queue()) {
                self.eventTypePicker.reloadData()
            }*/
        }
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.separatorInset = UIEdgeInsetsZero
        cell.layoutMargins = UIEdgeInsetsZero
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
}
