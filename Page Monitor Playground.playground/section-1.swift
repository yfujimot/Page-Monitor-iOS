// Playground - noun: a place where people can play

import UIKit

let url = NSURL(string: "http://google.com/")
//let source = NSString(contentsOfURL:url) //This way is deprecated
let source = String(contentsOfURL: url!, encoding: NSUTF8StringEncoding, error: nil); //and this is not

println(source)

println(source?.componentsSeparatedByString("<html>"))
