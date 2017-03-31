//
//  Location+CoreDataProperties.swift
//  Travel Journal
//
//  Created by Carl Lee on 3/31/17.
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
    @NSManaged public var note: NSSet?
    @NSManaged public var picture: NSSet?
    @NSManaged public var video: NSSet?

}

// MARK: Generated accessors for note
extension Location {

    @objc(addNoteObject:)
    @NSManaged public func addToNote(_ value: DetailedJournal)

    @objc(removeNoteObject:)
    @NSManaged public func removeFromNote(_ value: DetailedJournal)

    @objc(addNote:)
    @NSManaged public func addToNote(_ values: NSSet)

    @objc(removeNote:)
    @NSManaged public func removeFromNote(_ values: NSSet)

}

// MARK: Generated accessors for picture
extension Location {

    @objc(addPictureObject:)
    @NSManaged public func addToPicture(_ value: DetailedJournal)

    @objc(removePictureObject:)
    @NSManaged public func removeFromPicture(_ value: DetailedJournal)

    @objc(addPicture:)
    @NSManaged public func addToPicture(_ values: NSSet)

    @objc(removePicture:)
    @NSManaged public func removeFromPicture(_ values: NSSet)

}

// MARK: Generated accessors for video
extension Location {

    @objc(addVideoObject:)
    @NSManaged public func addToVideo(_ value: DetailedJournal)

    @objc(removeVideoObject:)
    @NSManaged public func removeFromVideo(_ value: DetailedJournal)

    @objc(addVideo:)
    @NSManaged public func addToVideo(_ values: NSSet)

    @objc(removeVideo:)
    @NSManaged public func removeFromVideo(_ values: NSSet)

}
