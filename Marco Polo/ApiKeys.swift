//
//  ApiKeys.swift
//  Ivizone
//
//  Created by James Dewar on 02/02/15.
//  Copyright (c) 2015 IviData. All rights reserved.
//

import Foundation

func valueForAPIKey(#keyname:String) -> String {
    let filePath = NSBundle.mainBundle().pathForResource("ApiKeys", ofType:"plist")
    let plist = NSDictionary(contentsOfFile:filePath!)
    
    let value:String = plist?.objectForKey(keyname) as String
    return value
}