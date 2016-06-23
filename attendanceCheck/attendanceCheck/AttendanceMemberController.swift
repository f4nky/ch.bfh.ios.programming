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

    //var sections = ["Trainer", "Spielerin"]
    /*var members = [[
            Member(id: 1, firstName: "Max", lastName: "Mustermann", birthDate: nil, memberType: nil),
            Member(id: 2, firstName: "Felix", lastName: "Muster", birthDate: nil, memberType: nil)
        ], [
            Member(id: 3, firstName: "Anna", lastName: "Schweizer", birthDate: nil, memberType: nil),
            Member(id: 4, firstName: "Erika", lastName: "Musterfrau", birthDate: nil, memberType: nil),
            Member(id: 5, firstName: "Jane", lastName: "Doe", birthDate: nil, memberType: nil)
        ]
    ]*/
    var event: Event?
    var sections = [String]()
    var attendances = [[Attendance]]()
    
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
        
        self.splitViewController!.preferredDisplayMode = UISplitViewControllerDisplayMode.PrimaryOverlay
        self.splitViewController!.preferredDisplayMode = UISplitViewControllerDisplayMode.AllVisible
        
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
        let cell = tableView.dequeueReusableCellWithIdentifier("memberCell", forIndexPath: indexPath) as! MemberCell

        let attendance = attendances[indexPath.section][indexPath.row]
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        
        cell.lblMemberName.text = (attendance.member?.firstName?.uppercaseString)! + " " + (attendance.member?.lastName?.uppercaseString)!
        cell.lblBirthDate.text = dateFormatter.stringFromDate((attendance.member?.birthDate)!)
        return cell
    }
}

