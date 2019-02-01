//
//  ItemType+CoreDataProperties.swift
//  UdemyCoreDataV1.3
//
//  Created by Miloš Čampar on 3/8/17.
//  Copyright © 2017 Miloš Čampar. All rights reserved.
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
