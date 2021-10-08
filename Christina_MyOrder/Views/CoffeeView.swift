//
//  CoffeeView.swift
//  Christina_MyOrder
//
//  Christina Zammit
//  991585165
//
//  Created by Christina Zammit on 2021-10-7.
//

import SwiftUI

struct CoffeeView: View {
    
    let selectedCoffeeIndex : Int
    
    // variable to hold value of coffee quantity
    @State private var quantity : String = ""

    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var coreDBHelper : CoreDBHelper
    
    var body: some View {
            
            VStack(alignment: .leading){
                
                Form {
                    
                    // section that contains quantity of coffee cups
                    Section(header: Text("How many cups?")) {
                        // text field for user to enter coffee cup quantity
                        TextField("Enter quantity", text: $quantity)
                            .padding(10)
                            .keyboardType(.numberPad)
                    }

                    HStack() {
                        Spacer()
                        
                        Button(action: {
                            self.updateCoffee()
                        }, label: {
                            // sets label for button
                            Text("Update Coffee Details")
                                .foregroundColor(Color.white)
                                .fontWeight(.bold)
                                .font(.body)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 10)
                            
                        })
                            .background(Color(red: 173/255, green: 150/255, blue: 134/255))
                            .cornerRadius(10)
                        
                        Spacer()
                        
                    }
                    .listRowBackground(Color.clear)
                        
                }//Form
                
                .navigationBarTitle("Update My Order", displayMode: .inline)
                .navigationBarBackButtonHidden(true)
                
            }//VStack
            .frame(maxWidth: .infinity)
            .onAppear(){
                self.quantity = self.coreDBHelper.coffeeList[selectedCoffeeIndex].quantity
            }
            .onDisappear(){
                self.coreDBHelper.coffeeList.removeAll()
                self.coreDBHelper.getAllCoffee()
                print(#function, "OnDisappear CoffeeView() : \(self.coreDBHelper.coffeeList)")
            }
        
    } //body
    
    private func updateCoffee(){
        self.coreDBHelper.coffeeList[selectedCoffeeIndex].quantity = self.quantity
        
        self.coreDBHelper.updateCoffee(updatedCoffee: self.coreDBHelper.coffeeList[selectedCoffeeIndex])
        self.presentationMode.wrappedValue.dismiss()
    }
}
