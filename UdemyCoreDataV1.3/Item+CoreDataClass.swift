//
//  Item+CoreDataClass.swift
//  UdemyCoreDataV1.3
//
//  Created by Miloš Čampar on 3/8/17.
//  Copyright © 2017 Miloš Čampar. All rights reserved.
//

import Foundation
import CoreData


public class Item: NSManagedObject {

    public override func awakeFromInsert() {
        
        super.awakeFromInsert()
        
        self.created = NSDate()
    }
    
}
