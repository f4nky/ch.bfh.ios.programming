//
//  MasterViewController.swift
//  attendanceCheck
//
//  Created by Fanky on 29.03.16.
//  Copyright © 2016 Fanky. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    @IBOutlet var memberTableView: UITableView!
    
    var detailViewController: DetailViewController? = nil
    //var manager: RestManager! = RestManager()
    //var members = [Member]()
    var sections = ["Trainer", "Spielerin"]
    var members = [[
        Member(id: 1, firstName: "Max", lastName: "Mustermann", birthDate: nil),
        Member(id: 2, firstName: "Felix", lastName: "Muster", birthDate: nil)
    ], [
        Member(id: 3, firstName: "Anna", lastName: "Schweizer", birthDate: nil),
        Member(id: 4, firstName: "Erika", lastName: "Musterfrau", birthDate: nil),
        Member(id: 5, firstName: "Jane", lastName: "Doe", birthDate: nil)
    ]]
    
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
        
        let nib = UINib(nibName: "vwMemberCell", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: "cell")
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

    func insertNewObject(sender: AnyObject) {
        //objects.insert(NSDate(), atIndex: 0)
        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            /*if let indexPath = self.tableView.indexPathForSelectedRow {
                let member = members[indexPath.row]
                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = member
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
            }*/
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

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return members[section].count
        //return members.count
    }

    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.separatorInset = UIEdgeInsetsZero
        cell.layoutMargins = UIEdgeInsetsZero
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: MemberCell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! MemberCell

        let member = members[indexPath.section][indexPath.row]
        //let member = members[indexPath.row]
        cell.lblMemberName.text = member.firstName.uppercaseString + " " + member.lastName.uppercaseString
        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            members.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }


}

