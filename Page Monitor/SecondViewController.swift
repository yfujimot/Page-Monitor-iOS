//
//  SecondViewController.swift
//  Page Monitor
//
//  Created by Yoshio Fujimoto on 12/8/14.
//  Copyright (c) 2014 ThinkFuji. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var linkTextField: UITextField!
    @IBAction func addButtonPressed(sender: AnyObject) {
        if ((linkTextField.text as NSString).length == 0) { // Invalid input
            var alertView = UIAlertView();
            alertView.addButtonWithTitle("Got it");
            alertView.title = "Failed";
            alertView.message = "Please enter a valid URL.";
            alertView.show();

        } else {
            pages.append(linkTextField.text) // Add item
        
            println(pages)
        
            let fixedPages = pages
            // NSUserDefaults.standardUserDefaults().setValue(fixedPages, forKey: "pages") // Save pages list
        
            var urlString = linkTextField.text as String // Local variable for less wasted space
            var url = NSURL(string: urlString) // Convert string literal to NSURL
        
            // Task declaration
            var task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
            
                var urlContent = NSString(data: data, encoding: NSUTF8StringEncoding) // Fetch current http
                println(urlContent)
            
                // Legacy data saving using userdefaults
                // NSUserDefaults.standardUserDefaults().setValue(urlContent, forKey: self.linkTextField.text) // Initial fetch for code
            
                /* Save data using Parse */
                
//                var gameScore = PFObject(className: "Test")
//                gameScore.setObject(1337, forKey: "score")
//                gameScore.setObject("Sean Plott", forKey: "playerName")
//                gameScore.saveInBackgroundWithBlock {
//                    (success: Bool!, error: NSError!) -> Void in
//                    if (success != nil) {
//                        println("Object created with id: \(gameScore.objectId)")
//                    } else {
//                        println("%@", error)
//                    }
//                }
                
                // Test fetch
                
                println("Fetching");
                
                var query = PFQuery(className: "Test")
                query.getObjectInBackgroundWithId("ywOtDPVpDi") {
                    (score: PFObject!, error: NSError!) -> Void in
                    if (error == nil) {
                        println(score)
                    } else {
                        println(error)
                    }
                }
            }
        
            task.resume() // Start task
        
            // NSUserDefaults.standardUserDefaults().synchronize() // Execute tasks
        
            self.view.endEditing(true)
        
            var alertView = UIAlertView();
            alertView.addButtonWithTitle("Got it");
            alertView.title = "Success";
            alertView.message = "Tracker Added!";
            alertView.show();
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Parse init
        
        Parse.setApplicationId("gxvIIPDD2rlIH7zTMBJMIQmIqg0uTrVjwvpGe1Mh", clientKey: "bZXyM7l97Nmv3cXnFtVtvCMN1XAG6LyvnsgPt821")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        linkTextField.resignFirstResponder()
        
        return true
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }


}

