//
//  Note+CoreDataClass.swift
//  Travel Journal
//
//  Created by Carl Lee on 4/6/17.
//  Copyright © 2017 Carl Lee. All rights reserved.
//

import Foundation
import CoreData

@objc(Note)
public class Note: NSManagedObject {
    
    convenience init(detailJ: String, context: NSManagedObjectContext){
        
        if let ent = NSEntityDescription.entity(forEntityName: "Note", in: context){
            
            self.init(entity: ent, insertInto: context)
            self.notes = detailJ
            
        } else{
            fatalError("Unable to find entity name")
        }
    }


}
