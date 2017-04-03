//
//  DetailedJournal+CoreDataClass.swift
//  Travel Journal
//
//  Created by Carl Lee on 3/31/17.
//  Copyright © 2017 Carl Lee. All rights reserved.
//

import Foundation
import CoreData

@objc(DetailedJournal)
public class DetailedJournal: NSManagedObject {
    
    convenience init(pic: NSData?, video: NSData?, detailJ: String?, context: NSManagedObjectContext){
        
        if let ent = NSEntityDescription.entity(forEntityName: "DetailedJournal", in: context){
            
            self.init(entity: ent, insertInto: context)
            self.photoData = pic
            self.videoData = video
            self.notes = detailJ
            
        } else{
            fatalError("Unable to find entity name")
        }
    }


}
