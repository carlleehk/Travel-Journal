//
//  Photo+CoreDataProperties.swift
//  Travel Journal
//
//  Created by Carl Lee on 4/6/17.
//  Copyright © 2017 Carl Lee. All rights reserved.
//

import Foundation
import CoreData


extension Photo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Photo> {
        return NSFetchRequest<Photo>(entityName: "Photo")
    }

    @NSManaged public var photoData: Data?
    @NSManaged public var location: Location?

}
