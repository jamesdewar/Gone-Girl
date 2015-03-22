 //
 //  SetUpView.swift
 //  Marco Polo
 //
 //  Created by James Dewar on 22/03/15.
 //  Copyright (c) 2015 IviData. All rights reserved.
 //
 
 import Foundation
 import UIKit
 
 
 class SetUpView: UIViewController, UIApplicationDelegate{
    
    
    
    @IBOutlet weak var Clue1: UITextField!
    @IBOutlet weak var Clue2: UITextField!
    @IBOutlet weak var Clue3: UITextField!
    @IBOutlet weak var Clue4: UITextField!
    var firstclue = ""
    var secondclue = ""
    var thirdclue = ""
    var fourthclue = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let parseApplicationId = valueForAPIKey(keyname: "PARSE_CLIENT_ID")
        let parseClientKey     = valueForAPIKey(keyname: "PARSE_CLIENT_KEY")
        Parse.setApplicationId(parseApplicationId, clientKey: parseClientKey)
    }
    
    
    
    @IBAction func clue_update(sender: UIButton) {
        firstclue = Clue1.text
        secondclue = Clue2.text
        thirdclue = Clue3.text
        fourthclue = Clue4.text
        var clueObject = PFObject(className:"CLueObjects")
        clueObject["clue1"] = firstclue
        clueObject["clue2"] = secondclue
        clueObject["clue3"] = thirdclue
        clueObject["clue4"] = fourthclue
        clueObject.saveInBackgroundWithBlock {
            (success: Bool, error: NSError!) -> Void in
            if (success) {
                // The object has been saved.
            } else {
                // There was a problem, check error.description
            }
        }
    }
     }
 
