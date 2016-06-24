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
    
    func changeAttendanceStatus(sender: UIButton) {
        let touchPoint: CGPoint = sender.convertPoint(CGPointZero, toView: memberTableView)
        let btnIndexPath: NSIndexPath = self.memberTableView.indexPathForRowAtPoint(touchPoint)!
        let attendance = attendances[btnIndexPath.section][btnIndexPath.row]
        var newStatus: String?
        
        if let status = attendance.status {
            switch status {
            case "ANW":
                newStatus = "ENT"
            case "ENT":
                newStatus = "UNE"
            case "UNE":
                newStatus = nil
            default:
                newStatus = "ANW"
            }
        } else {
            newStatus = "ANW"
        }
        attendance.status = newStatus
        
        AttendanceApi.updateAttendance(attendance.id!, body: attendance) {_ in}
        changeStatusBtnStyle(sender, newStatus: newStatus)
    }
    
    func changeStatusBtnStyle(btn: UIButton, newStatus: String?) {
        var img: UIImage?
        var bgColor: UIColor?
        var tintColor: UIColor?
        
        if let status = newStatus {
            switch status {
            case "ANW":
                bgColor = UIColor(red: 30/255, green: 160/255, blue: 100/255, alpha: 1)
                tintColor = UIColor(red: 40/255, green: 100/255, blue: 80/255, alpha: 1)
                img = UIImage(named: "check.png")
            case "ENT":
                bgColor = UIColor(red: 255/255, green: 210/255, blue: 90/255, alpha: 1)
                tintColor = UIColor(red: 205/255, green: 140/255, blue: 80/255, alpha: 1)
                img = UIImage(named: "times.png")
            case "UNE":
                bgColor = UIColor(red: 210/255, green: 75/255, blue: 65/255, alpha: 1)
                tintColor = UIColor(red: 145/255, green: 55/255, blue: 45/255, alpha: 1)
                img = UIImage(named: "times.png")
            default:
                bgColor = UIColor.clearColor()
                tintColor = UIColor(red: 115/255, green: 115/255, blue: 120/255, alpha: 1)
                img = UIImage(named: "question.png")
            }
        } else {
            bgColor = UIColor.clearColor()
            tintColor = UIColor(red: 115/255, green: 115/255, blue: 120/255, alpha: 1)
            img = UIImage(named: "question.png")
        }
        
        let tintedImg = img!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        btn.setImage(tintedImg, forState: .Normal)
        btn.backgroundColor = bgColor
        btn.tintColor = tintColor
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
        cell.btnMemberStatus.addTarget(self, action: #selector(DetailViewController.changeAttendanceStatus(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        changeStatusBtnStyle(cell.btnMemberStatus, newStatus: attendance.status)
        return cell
    }
}

