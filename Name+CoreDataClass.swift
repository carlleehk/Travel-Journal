//
//  Name+CoreDataClass.swift
//  Travel Journal
//
//  Created by Carl Lee on 3/31/17.
//  Copyright © 2017 Carl Lee. All rights reserved.
//

import Foundation
import CoreData

@objc(Name)
public class Name: NSManagedObject {
    
    convenience init(name: String, context: NSManagedObjectContext){
        
        if let ent = NSEntityDescription.entity(forEntityName: "Name", in: context){
            
            self.init(entity: ent, insertInto: context)
            self.journalName = name
            
        } else{
            fatalError("Unable to find entity name")
        }
    }

}
