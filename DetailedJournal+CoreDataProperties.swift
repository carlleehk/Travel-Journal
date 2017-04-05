//
//  DetailedJournal+CoreDataProperties.swift
//  Travel Journal
//
//  Created by Carl Lee on 4/5/17.
//  Copyright © 2017 Carl Lee. All rights reserved.
//

import Foundation
import CoreData


extension DetailedJournal {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DetailedJournal> {
        return NSFetchRequest<DetailedJournal>(entityName: "DetailedJournal")
    }

    @NSManaged public var notes: String?
    @NSManaged public var photoData: NSData?
    @NSManaged public var videoData: NSData?
    @NSManaged public var location: Location?

}
