//
//  FirstViewController.swift
//  Page Monitor
//
//  Created by Yoshio Fujimoto on 12/8/14.
//  Copyright (c) 2014 ThinkFuji. All rights reserved.
//

import UIKit

var pages:[String] = []
var tempData:String = ""

class FirstViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var pagesTable:UITableView? // Manually created referencing outlet
    
    var refreshControl:UIRefreshControl!  // An optional variable
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.refreshControl = UIRefreshControl() // Off center
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        pagesTable?.addSubview(refreshControl)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pages.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        
        cell.textLabel?.text = pages[indexPath.row]
        
        return cell
    }
    
    func refresh(sender: AnyObject) { // Pro version will check in background then push. Free is manual..
        println("Refresh works!")
        pagesTable?.reloadData() // Not absolutely sure if this one is necessary
        
        /* Iterate through each page within current user data, fetch source and if changes detected, alert user */
        var idx = 0
        
        while (idx < pages.count) {
            println(idx)
            let indexPath = NSIndexPath(forRow: idx, inSection: 0)
            let cell = tableView(pagesTable!, cellForRowAtIndexPath: indexPath)
            pagesTable?.selectRowAtIndexPath(indexPath, animated: false, scrollPosition: UITableViewScrollPosition.None)
            println("Current cell: \(cell.textLabel?.text)")
            
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
            cell.textLabel?.text = "It worked!"
            
            cell.reloadInputViews()
            pagesTable?.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.None)
            pagesTable?.reloadData()
            println("Reloaded")
            idx++
        }
        
        
        /* Provide visual alert */
        pagesTable?.reloadData()
        self.refreshControl.endRefreshing() // End refreshing
    }
    
    override func viewWillAppear(animated: Bool) {
        
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        pages.removeAtIndex(indexPath.row) // Delete item
        
        let fixedToDoItems = pages
        
        pagesTable?.reloadData()
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

    }
    
    func tableView(tableView: UITableView, performAction action: Selector, forRowAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject!) {
        let cell = pagesTable?.cellForRowAtIndexPath(indexPath)
        cell?.textLabel?.text = "Worked"
        
    }
    
    
}

