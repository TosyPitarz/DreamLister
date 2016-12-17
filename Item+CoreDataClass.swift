//
//  Item+CoreDataClass.swift
//  DreamLister
//
//  Created by Tosin Peters on 2016-12-16.
//  Copyright © 2016 Tosin Peters. All rights reserved.
//

import Foundation
import CoreData

@objc(Item)
public class Item: NSManagedObject {
    
    public override func awakeFromInsert() {
        
        super.awakeFromInsert()
        //creating a time stamp for your items
        
        self.created = NSDate()
    }
}
