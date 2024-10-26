//
//  Collected+CoreDataProperties.swift
//  Zomo
//
//  Created by Liya Wang on 2024/4/22.
//
//

import Foundation
import CoreData


extension Collected {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Collected> {
        return NSFetchRequest<Collected>(entityName: "Collected")
    }

    @NSManaged public var relationship: Animal?

}

extension Collected : Identifiable {

}
