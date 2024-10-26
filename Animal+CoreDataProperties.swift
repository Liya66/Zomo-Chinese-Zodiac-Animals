//
//  Animal+CoreDataProperties.swift
//  Zomo
//
//  Created by Liya Wang on 2024/4/22.
//
//

import Foundation
import CoreData


extension Animal {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Animal> {
        return NSFetchRequest<Animal>(entityName: "Animal")
    }

    @NSManaged public var character: String?
    @NSManaged public var element: String?
    @NSManaged public var image: String?
    @NSManaged public var image2: String?
    @NSManaged public var isCollected: Bool
    @NSManaged public var name: String?
    @NSManaged public var orderIndex: Int32
    @NSManaged public var trine: String?
    @NSManaged public var url: String?
    @NSManaged public var yy: String?

}

extension Animal : Identifiable {

}
