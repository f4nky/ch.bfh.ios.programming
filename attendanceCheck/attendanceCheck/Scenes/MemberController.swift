//
//  MemberController.swift
//  attendanceCheck
//
//  Created by Fanky on 21.06.16.
//  Copyright © 2016 Fanky. All rights reserved.
//

import UIKit

class MemberController: UITableViewController {

    @IBOutlet var memberTableView: UITableView!

    @IBAction func cancelToList(segue: UIStoryboardSegue) {
        
    }
    @IBAction func saveMember(segue: UIStoryboardSegue) {
        if let memberDetailsController = segue.sourceViewController as? MemberNewController {
            if let member = memberDetailsController.member {
                MemberApi.saveMember(member) {_ in}
                loadMemberData()
            }
        }
    }
    
    var sections = [String]()
    var members = [[Member]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.refreshControl?.addTarget(self, action: #selector(MemberController.refresh(_:)), forControlEvents: UIControlEvents.ValueChanged)
        
        let nibHeaderCell = UINib(nibName: "vwMemberAttendanceHeaderCell", bundle: nil)
        memberTableView.registerNib(nibHeaderCell, forCellReuseIdentifier: "memberAttendanceHeaderCell")
        
        memberTableView.sectionHeaderHeight = 20.0
        
        let nibMemberCell = UINib(nibName: "vwMemberCell", bundle: nil)
        memberTableView.registerNib(nibMemberCell, forCellReuseIdentifier: "memberCell")
        
        memberTableView.delegate = self
        memberTableView.dataSource = self
        memberTableView.separatorInset = UIEdgeInsetsZero
        memberTableView.layoutMargins = UIEdgeInsetsZero
        memberTableView.rowHeight = 50.0
        
        loadMemberData()
    }
    
    func refresh(sender:AnyObject) {
        self.sections = [String]()
        self.members = [[Member]]()
        loadMemberData()
        self.refreshControl?.endRefreshing()
    }
    
    func loadMemberData() {
        MemberApi.getMembers() {members in
            var tmpMemberType: String?
            var tmpMembers = [Member]()
            
            tmpMemberType = nil
            
            for member in members {
                print(member.birthDate)
                if (member.memberType?.name != tmpMemberType) {
                    if (tmpMemberType != nil) {
                        self.members.append(tmpMembers)
                        tmpMembers = [Member]()
                    }
                    tmpMembers.append(member)
                    self.sections.append((member.memberType?.name)!)
                    tmpMemberType = member.memberType?.name
                } else {
                    tmpMembers.append(member)
                }
            }
            if (tmpMembers.count > 0) {
                self.members.append(tmpMembers)
            }
   
            dispatch_async(dispatch_get_main_queue()) {
                self.tableView.reloadData()
            }
        }
    }
    
    func deleteMember(id: Int) {
        MemberApi.deleteMember(id) {_ in}
        self.sections = [String]()
        self.members = [[Member]]()
        loadMemberData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return sections.count
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerCell = tableView.dequeueReusableCellWithIdentifier("memberAttendanceHeaderCell") as! MemberAttendanceHeaderCell
        
        headerCell.lblTitle!.text = sections[section].uppercaseString
        
        return headerCell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return members[section].count
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.separatorInset = UIEdgeInsetsZero
        cell.layoutMargins = UIEdgeInsetsZero
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("memberCell", forIndexPath: indexPath) as! MemberCell
        
        let member = members[indexPath.section][indexPath.row]
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        
        cell.lblMemberName.text = member.firstName!.uppercaseString + " " + member.lastName!.uppercaseString
        cell.lblBirthDate.text = dateFormatter.stringFromDate(member.birthDate!)
        return cell
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            let member = members[indexPath.section][indexPath.row]
            deleteMember(member.id!)
        }
    }
}
