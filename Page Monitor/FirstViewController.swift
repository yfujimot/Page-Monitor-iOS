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
    
    func refresh(sender: AnyObject) { // Pro version will check in background then push. Free is manual..
        println("Refresh works!")
        pagesTable?.reloadData() // Not absolutely sure if this one is necessary
        
        for page in pages { // Iterate and check page changes. Code inspector goes in here.
            // Initialize link information
            var urlString = page as String // Local variable for less wasted space
            var url = NSURL(string: urlString) // Convert string literal to NSURL
            
            // Task declaration
            var task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
//                
//                var urlContent:String = NSString(data: data, encoding: NSUTF8StringEncoding) as String // Fetch current http
//                println(urlContent)
//                
//                var urlContent2 = NSString(data: data, encoding: NSUTF8StringEncoding) // Fetch current http
//                println(urlContent2)
//                
//                var savedData:String = NSUserDefaults.standardUserDefaults().valueForKey(page) as String
//                
//                
//                println("Before string isempty");
//                
//                if (savedData.isEmpty) {
//                    println("Page could not be found in dictionary")
//                }
//                
//                if (tempData != urlContent) {
//                    println("Page has changed!")
//                } else {
//                    println("Page has not changed..");
//                }
//                
//                /* Does not work for:
//                Github
//                */
//                
//                tempData = urlContent
//                NSUserDefaults.standardUserDefaults().setValue(urlContent, forKey: page) // Update current http
//                NSUserDefaults.standardUserDefaults().synchronize() // Commit
            }
            
            task.resume() // Start task
            
        }
        
        pagesTable?.reloadData()
        self.refreshControl.endRefreshing() // End refreshing
    }
    
    override func viewWillAppear(animated: Bool) {
        
        
//        if var storedToDoItems : AnyObject = NSUserDefaults.standardUserDefaults().objectForKey("pages") {
//            
//            pages = [] // Clear list
//            
//            for (var idx = 0; idx < storedToDoItems.count; idx++) {
//                pages.append(storedToDoItems[idx] as NSString)
//            }
//        }
//        
//        pagesTable?.reloadData()
        
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        pages.removeAtIndex(indexPath.row) // Delete item
        
        let fixedToDoItems = pages
        
//        NSUserDefaults.standardUserDefaults().setValue(fixedToDoItems, forKey: "pages")
//        NSUserDefaults.standardUserDefaults().synchronize()
        
        pagesTable?.reloadData()
    }
}

