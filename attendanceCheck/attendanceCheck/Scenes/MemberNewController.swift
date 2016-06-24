//
//  MemberNewController.swift
//  attendanceCheck
//
//  Created by Fanky on 23.06.16.
//  Copyright © 2016 Fanky. All rights reserved.
//

import UIKit

class MemberNewController: UITableViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet var memberTableView: UITableView!
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var memberTypePicker: UIPickerView!
    @IBOutlet weak var memberBirthDatePicker: UIDatePicker!
    
    var member: Member?
    var memberTypes = [MemberType]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        memberTableView.delegate = self
        memberTableView.dataSource = self
        memberTableView.separatorInset = UIEdgeInsetsZero
        memberTableView.layoutMargins = UIEdgeInsetsZero
        memberTableView.rowHeight = 50.0
        
        loadMemberTypeData()
        
        self.navigationController!.navigationBar.tintColor = UIColor.whiteColor();
    }
    
    func loadMemberTypeData() {
        MemberTypeApi.getMemberTypes() {memberTypes in
            self.memberTypes = memberTypes
            dispatch_async(dispatch_get_main_queue()) {
                self.memberTypePicker.reloadAllComponents()
            }
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if (indexPath.section == 2 || indexPath.section == 3) {
            return 100
        }
        return self.tableView.rowHeight
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return memberTypes.count;
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return memberTypes[row].name
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "saveMemberDetails" {
            let firstName = txtFirstName.text
            let lastName = txtLastName.text
            let memberType = memberTypes[memberTypePicker.selectedRowInComponent(0)]
            let memberBirthDate = memberBirthDatePicker.date
            member = Member(id: nil, firstName: firstName, lastName: lastName, birthDate: memberBirthDate, memberType: memberType)
        }
    }
}
