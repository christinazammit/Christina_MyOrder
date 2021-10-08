//
//  CoreDBHelper.swift
//  Christina_MyOrder
//
//  Christina Zammit
//  991585165
//
//  Created by Christina Zammit on 2021-10-7.
//

import Foundation
import CoreData
import UIKit

class CoreDBHelper: ObservableObject{
    
    @Published var coffeeList = [CoffeeMO]()
    
    private static var shared : CoreDBHelper?
    
    static func getInstance() -> CoreDBHelper {
        if shared != nil{
            return shared!
        }else{
            shared = CoreDBHelper(context: PersistenceController.preview.container.viewContext)
            return shared!
        }
    }
    
    private let moc : NSManagedObjectContext
    private let ENTITY_NAME = "CoffeeMO"
    
    init(context: NSManagedObjectContext){
        self.moc = context
    }
    
    func insertTask(coffee: Coffee){
        do{
            
            let coffeeToBeInserted = NSEntityDescription.insertNewObject(forEntityName: ENTITY_NAME, into: self.moc) as! CoffeeMO
            
            coffeeToBeInserted.flavour = coffee.cFlavour
            coffeeToBeInserted.size = coffee.cSize
            coffeeToBeInserted.quantity = coffee.cQuantity
            coffeeToBeInserted.id = UUID()
            coffeeToBeInserted.dateAdded = Date()
            
            if self.moc.hasChanges{
                try self.moc.save()
                print(#function, "Data is saved successfully")
            }
            
        }
        catch let error as NSError{
            print(#function, "Could not save the data \(error)")
        }
    }
    
    func getAllCoffee(){
        let fetchRequest = NSFetchRequest<CoffeeMO>(entityName: ENTITY_NAME)
        fetchRequest.sortDescriptors = [NSSortDescriptor.init(key: "dateAdded", ascending: false)]
        
        do{
            let result = try self.moc.fetch(fetchRequest)
            print(#function, "Number of records fetched : \(result.count)")
            self.coffeeList.removeAll()
            self.coffeeList.insert(contentsOf: result, at: 0)
            
        }
        catch let error as NSError{
            print(#function, "Could not fetch data from Database \(error)")
        }
    }
    
    private func searchCoffee(coffeeID : UUID) -> CoffeeMO?{
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: ENTITY_NAME)
        let predicateID = NSPredicate(format: "id == %@", coffeeID as CVarArg)
        fetchRequest.predicate = predicateID
        
        do{
            let result = try self.moc.fetch(fetchRequest)
            if result.count > 0{
                return result.first as? CoffeeMO
            }
        }
        catch let error as NSError{
            print(#function, "Unable to search for data \(error)")
        }
        
        return nil
        
    }
    
    func deleteCoffee(coffeeID : UUID){
        let searchResult = self.searchCoffee(coffeeID: coffeeID)
        
        if (searchResult != nil){
            do {
                self.moc.delete(searchResult!)
                try self.moc.save()
                objectWillChange.send()
                print(#function, "Data deleted successfully")
            }
            catch let error as NSError{
                print(#function, "Couldn't delete data \(error)")
            }
        } else {
            print(#function, "No matching record found")
        }
    }
    
    func updateCoffee(updatedCoffee: CoffeeMO){
        let searchResult = self.searchCoffee(coffeeID: updatedCoffee.id! as UUID)
        
        if (searchResult != nil){
            do {
                let coffeeToUpdate = searchResult!
                
                coffeeToUpdate.flavour = updatedCoffee.flavour
                coffeeToUpdate.size = updatedCoffee.size
                coffeeToUpdate.quantity = updatedCoffee.quantity
                
                try self.moc.save()
                objectWillChange.send()
                print(#function, "Data Updated Successfully")
                
            } catch let error as NSError{
                print(#function, "Unable to update data \(error)")
            }
        } else {
            print(#function, "No matching data found")
        }
    }
}
