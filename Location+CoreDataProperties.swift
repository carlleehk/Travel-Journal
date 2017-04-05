//
//  Location+CoreDataProperties.swift
//  Travel Journal
//
//  Created by Carl Lee on 4/5/17.
//  Copyright © 2017 Carl Lee. All rights reserved.
//

import Foundation
import CoreData


extension Location {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Location> {
        return NSFetchRequest<Location>(entityName: "Location")
    }

    @NSManaged public var lat: Double
    @NSManaged public var long: Double
    @NSManaged public var name: Name?
    @NSManaged public var detailedJournal: NSSet?

}

// MARK: Generated accessors for detailedJournal
extension Location {

    @objc(addDetailedJournalObject:)
    @NSManaged public func addToDetailedJournal(_ value: DetailedJournal)

    @objc(removeDetailedJournalObject:)
    @NSManaged public func removeFromDetailedJournal(_ value: DetailedJournal)

    @objc(addDetailedJournal:)
    @NSManaged public func addToDetailedJournal(_ values: NSSet)

    @objc(removeDetailedJournal:)
    @NSManaged public func removeFromDetailedJournal(_ values: NSSet)

}
