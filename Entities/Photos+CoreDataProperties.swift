//
//  Photos+CoreDataProperties.swift
//  Meditation
//
//  Created by Sergio Ramos on 24.03.2021.
//
//

import Foundation
import CoreData


extension Photos {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Photos> {
        return NSFetchRequest<Photos>(entityName: "Photos")
    }

    @NSManaged public var picture: Data?
    @NSManaged public var time: String?

}

extension Photos : Identifiable {

}
