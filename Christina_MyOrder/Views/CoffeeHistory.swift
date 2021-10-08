//
//  coffeeHistory.swift
//  Christina_MyOrder
//
//  Christina Zammit
//  991585165
//
//  Created by Christina Zammit on 2021-10-7.
//

import SwiftUI

struct coffeeHistory: View {
    
    //NEW
    @State private var selectedIndex : Int = -1
    @State private var selection : Int? = nil
    @State private var showCoffeeOrder : Bool = false
    @EnvironmentObject var coreDBHelper : CoreDBHelper
    
    var body: some View {

        NavigationView{
            ZStack(alignment: .bottom){
                NavigationLink(destination: CoffeeView(selectedCoffeeIndex: self.selectedIndex), tag: 1, selection: $selection){}
                
                if (self.coreDBHelper.coffeeList.count > 0){
                    List {
                        ForEach (self.coreDBHelper.coffeeList.enumerated().map({$0}), id: \.element.self) { indx, currentCoffee in
                                VStack(alignment: .leading){

                                    Text("\(currentCoffee.quantity) cup(s) of \(currentCoffee.size) \(currentCoffee.flavour) coffee")
                                        .fontWeight(.bold)
                                    
                                }
                                .onTapGesture {
                                    self.selectedIndex = indx
                                    self.selection = 1
                                    print(#function, "\(String(describing: self.coreDBHelper.coffeeList[selectedIndex].flavour)) selected")
                                }
                        }//ForEach
                        .onDelete(perform: { indexSet in
                            for index in indexSet{
                                print(#function, "Coffee to delete : \(String(describing: self.coreDBHelper.coffeeList[index].flavour))")
                                self.coreDBHelper.deleteCoffee(coffeeID: self.coreDBHelper.coffeeList[index].id!)
                                self.coreDBHelper.coffeeList.remove(at: index)
                            }
                        })//onDelete
                    }//List
                }else{
                    VStack{
                        Text("There are no coffee orders added yet.")
                        Spacer()
                    }//VStack
                }//else
            }//ZStack
            .navigationBarTitle("My Orders", displayMode: .inline)
        }//NavigationView
        .onAppear(){
            self.coreDBHelper.getAllCoffee()
        }
    }//body
    
} // view


struct coffeeHistory_Previews: PreviewProvider {
    static var previews: some View {
        coffeeHistory().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
