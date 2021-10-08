//
//  Coffee.swift
//  Christina_MyOrder
//
//  Christina Zammit
//  991585165
//
//  Created by Christina Zammit on 2021-10-7.
//

import Foundation

struct Coffee : Identifiable, Hashable{
    var id = UUID()
    var cFlavour: String = ""
    var cSize : String = ""
    var cQuantity: String = ""
    
    init() {
    }
    
    init(cFlavour: String, cSize: String, cQuantity: String){
        self.cFlavour = cFlavour
        self.cSize = cSize
        self.cQuantity = cQuantity
    }
    
    init(cID: UUID, cFlavour: String, cSize: String, cQuantity: String){
        self.id = cID
        self.cFlavour = cFlavour
        self.cSize = cSize
        self.cQuantity = cQuantity
    }
}
