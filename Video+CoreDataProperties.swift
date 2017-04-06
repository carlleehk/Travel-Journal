//
//  Video+CoreDataProperties.swift
//  Travel Journal
//
//  Created by Carl Lee on 4/6/17.
//  Copyright © 2017 Carl Lee. All rights reserved.
//

import Foundation
import CoreData


extension Video {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Video> {
        return NSFetchRequest<Video>(entityName: "Video")
    }

    @NSManaged public var videoPhoto: NSData?
    @NSManaged public var videoData: NSData?
    @NSManaged public var location: Location?

}
