//
//  CoffeeMO.swift
//  Christina_MyOrder
//
//  Christina Zammit
//  991585165
//
//  Created by Christina Zammit on 2021-10-7.
//

import Foundation
import CoreData

@objc(CoffeeMO)
final class CoffeeMO: NSManagedObject{
    @NSManaged var id: UUID?
    @NSManaged var flavour: String
    @NSManaged var size: String
    @NSManaged var quantity: String
    @NSManaged var dateAdded: Date
}

extension CoffeeMO{
    func convertToCoffee() -> Coffee{
        Coffee(cID: id ?? UUID(), cFlavour: flavour, cSize: size, cQuantity: quantity)
    }
}
