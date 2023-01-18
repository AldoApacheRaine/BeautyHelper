//
//  Product+CoreDataProperties.swift
//  BeautyHelper
//
//  Created by Максим Хмелев on 18.01.2023.
//
//

import Foundation
import CoreData


extension Product {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Product> {
        return NSFetchRequest<Product>(entityName: "Product")
    }

    @NSManaged public var date: Date?
    @NSManaged public var ingredients: [String]?
    @NSManaged public var name: String?
    @NSManaged public var image: Data?

}

extension Product : Identifiable {

}
