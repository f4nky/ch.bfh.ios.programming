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

    var event: Event?
    var sections = [String]()
    var attendances = [[Attendance]]()
    let dateFormatter = NSDateFormatter()
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nibHeaderCell = UINib(nibName: "vwMemberHeaderCell", bundle: nil)
        memberTableView.registerNib(nibHeaderCell, forCellReuseIdentifier: "memberHeaderCell")
        
        memberTableView.sectionHeaderHeight = 20.0
        
        let nibMemberCell = UINib(nibName: "vwMemberAttendanceCell", bundle: nil)
        memberTableView.registerNib(nibMemberCell, forCellReuseIdentifier: "memberAttendanceCell")
        
        memberTableView.delegate = self
        memberTableView.dataSource = self
        memberTableView.separatorInset = UIEdgeInsetsZero
        memberTableView.layoutMargins = UIEdgeInsetsZero
        memberTableView.rowHeight = 50.0
        
        self.splitViewController!.preferredDisplayMode = UISplitViewControllerDisplayMode.PrimaryOverlay
        self.splitViewController!.preferredDisplayMode = UISplitViewControllerDisplayMode.AllVisible
        
        dateFormatter.dateFormat = "dd.MM.yyyy"
        
        self.title = "Anwesenheiten, " + dateFormatter.stringFromDate((self.event?.date)!)
        
        if self.event != nil {
            loadAttendanceData()
        }
    }
    
    func loadAttendanceData() {
        AttendanceApi.getAttendancesForEvent(self.event!) {attendances in
            var tmpMemberType: String?
            var tmpAttendances = [Attendance]()
            
            tmpMemberType = nil
            
            for attendance in attendances {
                if (attendance.member!.memberType?.name != tmpMemberType) {
                    if (tmpMemberType != nil) {
                        self.attendances.append(tmpAttendances)
                        tmpAttendances = [Attendance]()
                    }
                    tmpAttendances.append(attendance)
                    self.sections.append((attendance.member!.memberType?.name)!)
                    tmpMemberType = attendance.member!.memberType?.name
                } else {
                    tmpAttendances.append(attendance)
                }
            }
            if (tmpAttendances.count > 0) {
                self.attendances.append(tmpAttendances)
            }
            
            dispatch_async(dispatch_get_main_queue()) {
                self.memberTableView.reloadData()
            }
        }
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return sections.count
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
        return attendances[section].count
        //return attendances.count
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.separatorInset = UIEdgeInsetsZero
        cell.layoutMargins = UIEdgeInsetsZero
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("memberAttendanceCell", forIndexPath: indexPath) as! MemberAttendanceCell

        let attendance = attendances[indexPath.section][indexPath.row]
        
        cell.lblMemberName.text = (attendance.member?.firstName?.uppercaseString)! + " " + (attendance.member?.lastName?.uppercaseString)!
        cell.lblBirthDate.text = dateFormatter.stringFromDate((attendance.member?.birthDate)!)
        return cell
    }
}

