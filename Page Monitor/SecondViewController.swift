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
    @IBOutlet weak var sourceView: UITextView!
    @IBAction func addButtonPressed(sender: AnyObject) {
        if ((linkTextField.text as NSString).length == 0) { // Invalid input
            var alertView = UIAlertView();
            alertView.addButtonWithTitle("Got it");
            alertView.title = "Failed";
            alertView.message = "Please enter a valid URL.";
            alertView.show();

        } else {
            var urlString = linkTextField.text as String // Local variable for less wasted space
            
            if !(urlString.hasPrefix("http://www.")) { // Invalid format
                var alertView = UIAlertView()
                alertView.addButtonWithTitle("Got it")
                alertView.title = "Failed"
                alertView.message = "Please enter the url in the format: http://www.google.com"
                alertView.show()
            } else {

                pages.append(linkTextField.text) // Add item
                
                println(pages)

                let url = NSURL(string: urlString)
                let source = String(contentsOfURL: url!, encoding: NSUTF8StringEncoding, error: nil);
                println(source)
                sourceView.text = source
                
                if (source?.rangeOfString("FailureMode=1") != nil) {
                    println("Query failed")
                } else {
                    println("Valid query")
                }
                
                /* Upload to Parse */
                var page = PFObject(className: "Pages")
                page.setObject(urlString, forKey: "url")
                page.setObject(source, forKey: "html")
                page.saveInBackgroundWithBlock {
                    (success: Bool!, error: NSError!) -> Void in
                    if (success != nil) {
                        println("Object created with id: \(page.objectId)")
                        var query = PFQuery(className: "Pages")
                        query.getObjectInBackgroundWithId(page.objectId) {
                            (score: PFObject!, error: NSError!) -> Void in
                            if (error == nil) {
                                println(score)
                            } else {
                                println(error)
                            }
                        }
                    } else {
                        println("%@", error)
                    }
                }
                
                self.view.endEditing(true)
            
                var alertView = UIAlertView()
                alertView.addButtonWithTitle("Got it")
                alertView.title = "Success"
                alertView.message = "Tracker Added!"
                alertView.show()
                
                if let tabBarController = self.sourceView.window!.rootViewController as? UITabBarController {
                    tabBarController.selectedIndex = 0 // Return to table view after success
                }
                
            }
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

