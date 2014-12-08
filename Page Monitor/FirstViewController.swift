//
//  FirstViewController.swift
//  Page Monitor
//
//  Created by Yoshio Fujimoto on 12/8/14.
//  Copyright (c) 2014 ThinkFuji. All rights reserved.
//

import UIKit

var pages:[String] = []

class FirstViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var pagesTable:UITableView? // Manually created referencing outlet
    var refreshControl:UIRefreshControl!  // An optional variable
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.refreshControl = UIRefreshControl()
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
        
        cell.textLabel.text = pages[indexPath.row]
        
        return cell
    }
    
    func refresh(sender: AnyObject) {
        println("Refresh works!")
        for page in pages { // Iterate and check page changes. Code inspector goes in here.
            var urlString = page as String
            println(urlString)
        }
        
        self.refreshControl.endRefreshing()
    }
    
    override func viewWillAppear(animated: Bool) {
        
        
        if var storedToDoItems : AnyObject = NSUserDefaults.standardUserDefaults().objectForKey("pages") {
            
            pages = [] // Clear list
            
            for (var idx = 0; idx < storedToDoItems.count; idx++) {
                pages.append(storedToDoItems[idx] as NSString)
            }
        }
        
        pagesTable?.reloadData()
        
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        pages.removeAtIndex(indexPath.row) // Delete item
        
        let fixedToDoItems = pages
        
        NSUserDefaults.standardUserDefaults().setValue(fixedToDoItems, forKey: "pages")
        NSUserDefaults.standardUserDefaults().synchronize()
        
        pagesTable?.reloadData()
    }
}

