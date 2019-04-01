//
//  Event+CoreDataProperties.swift
//  Project1
//
//  Created by LUN WING KIT on 31/3/2019.
//  Copyright © 2019 LUN WING KIT. All rights reserved.
//
//

import Foundation
import CoreData


extension Event {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Event> {
        return NSFetchRequest<Event>(entityName: "Event")
    }

    @NSManaged public var allDay: Bool
    @NSManaged public var endDate: NSDate?
    @NSManaged public var location: String?
    @NSManaged public var notes: String?
    @NSManaged public var startDate: NSDate?
    @NSManaged public var title: String?

}
