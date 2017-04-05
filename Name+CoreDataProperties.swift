//
//  Name+CoreDataProperties.swift
//  Travel Journal
//
//  Created by Carl Lee on 4/5/17.
//  Copyright © 2017 Carl Lee. All rights reserved.
//

import Foundation
import CoreData


extension Name {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Name> {
        return NSFetchRequest<Name>(entityName: "Name")
    }

    @NSManaged public var journalName: String?
    @NSManaged public var location: NSSet?

}

// MARK: Generated accessors for location
extension Name {

    @objc(addLocationObject:)
    @NSManaged public func addToLocation(_ value: Location)

    @objc(removeLocationObject:)
    @NSManaged public func removeFromLocation(_ value: Location)

    @objc(addLocation:)
    @NSManaged public func addToLocation(_ values: NSSet)

    @objc(removeLocation:)
    @NSManaged public func removeFromLocation(_ values: NSSet)

}
