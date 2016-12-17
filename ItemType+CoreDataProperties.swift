//
//  ItemType+CoreDataProperties.swift
//  DreamLister
//
//  Created by Tosin Peters on 2016-12-16.
//  Copyright © 2016 Tosin Peters. All rights reserved.
//

import Foundation
import CoreData


extension ItemType {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ItemType> {
        return NSFetchRequest<ItemType>(entityName: "ItemType");
    }

    @NSManaged public var type: String?
    @NSManaged public var toItem: Item?

}
