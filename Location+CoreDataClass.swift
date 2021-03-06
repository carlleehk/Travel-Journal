//
//  Location+CoreDataClass.swift
//  Travel Journal
//
//  Created by Carl Lee on 3/31/17.
//  Copyright © 2017 Carl Lee. All rights reserved.
//

import Foundation
import CoreData

@objc(Location)
public class Location: NSManagedObject {
    
    convenience init(lat: Double, long: Double, name: String, date: Date, context: NSManagedObjectContext){
        
        if let ent = NSEntityDescription.entity(forEntityName: "Location", in: context){
            
            self.init(entity: ent, insertInto: context)
            self.lat = lat
            self.long = long
            self.locationName = name
            self.creationDate = date
            
        } else{
            fatalError("Unable to find entity name")
        }
    }


}
