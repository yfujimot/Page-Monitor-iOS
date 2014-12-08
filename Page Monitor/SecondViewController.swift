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
        
        pages.append(linkTextField.text) // Add item
        
        println(pages)
        
        let fixedPages = pages
        NSUserDefaults.standardUserDefaults().setValue(fixedPages, forKey: "pages") // Save pages list
        
        var urlString = linkTextField.text as String // Local variable for less wasted space
        var url = NSURL(string: urlString) // Convert string literal to NSURL
        
        // Task declaration
        var task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
            
            var urlContent = NSString(data: data, encoding: NSUTF8StringEncoding) // Fetch current http
            println(urlContent)
            
            NSUserDefaults.standardUserDefaults().setValue(urlContent, forKey: self.linkTextField.text) // Initial fetch for code
            
        }
        
        task.resume() // Start task
        
        NSUserDefaults.standardUserDefaults().synchronize() // Execute tasks
        
        self.view.endEditing(true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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

