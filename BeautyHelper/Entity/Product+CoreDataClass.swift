//
//  Product+CoreDataClass.swift
//  BeautyHelper
//
//  Created by Максим Хмелев on 16.01.2023.
//
//

import Foundation
import CoreData

@objc(Product)
public class Product: NSManagedObject {
    convenience init() {
        self.init(entity: CoreDataManager.shared.entityForName("Product"), insertInto: CoreDataManager.shared.context)
    }
 }
