//
//  Photo+CoreDataClass.swift
//  Travel Journal
//
//  Created by Carl Lee on 4/6/17.
//  Copyright © 2017 Carl Lee. All rights reserved.
//

import Foundation
import CoreData

@objc(Photo)
public class Photo: NSManagedObject {
    
    convenience init(photo: NSData, context: NSManagedObjectContext){
        
        if let ent = NSEntityDescription.entity(forEntityName: "Photo", in: context){
            
            self.init(entity: ent, insertInto: context)
            self.photoData = photo
            
        } else{
            fatalError("Unable to find entity name")
        }
    }


}
