//
//  Video+CoreDataClass.swift
//  Travel Journal
//
//  Created by Carl Lee on 4/6/17.
//  Copyright © 2017 Carl Lee. All rights reserved.
//

import Foundation
import CoreData

@objc(Video)
public class Video: NSManagedObject {

    convenience init(video: NSData?, pic: Data?, context: NSManagedObjectContext){
        
        if let ent = NSEntityDescription.entity(forEntityName: "Video", in: context){
            
            self.init(entity: ent, insertInto: context)
            self.videoData = video
            self.videoPhoto = pic
            
        } else{
            fatalError("Unable to find entity name")
        }
    }

    
}
