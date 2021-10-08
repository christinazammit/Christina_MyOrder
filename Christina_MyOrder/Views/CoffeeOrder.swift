//
//  ContentView.swift
//  Christina_MyOrder
//
//  Christina Zammit
//  991585165
//
//  Created by Christina Zammit on 2021-10-7.
// 

import SwiftUI
import UIKit

struct coffeeOrder: View {
    
    // variable to store coffee type from picker, initializing it with original
    @State private var flavour : String = "Original Blend"
    var flavours = ["Original Blend", "Dark Roast", "Vanilla"]
    
    // variable to store coffee size from picker, initializing it with size small
    @State private var size : String = "Small"
    var sizes = ["Small", "Medium", "Large"]
    
    // variable to hold value of coffee quantity
    @State private var quantity : String = ""
    
    // variable to hold value of selection
    @State private var selection: Int? = nil
    
    // variable to hold value of the alert message
    @State private var alertMessage : String = ""
    
    @State private var showErrorAlert: Bool = false
    
    // variable to hold value of an invalid order
    @State private var invalidOrder: Bool = false
    
    // variable to hold value of alert title
    @State private var alertTitle: String = ""
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var coreDBHelper : CoreDBHelper
     
    var body: some View {
        
        NavigationView {
            
            VStack {
                
                // creates navigation link to coffee history page
                NavigationLink(destination: coffeeHistory(), tag: 1, selection: $selection) {}
            
                Form {
                    
                    // section that contains picker of coffee flavours
                    Section(header: Text("Which flavour?")) {
                        Picker(selection: $flavour, label:
                            Text("Coffee Flavour")) {
                            ForEach (flavours, id: \.self) {
                                Text($0)
                            }
                        }
                    }
                   
                    // section that contains picker of coffee sizes
                    Section(header: Text("Which size?")) {
                        Picker(selection: $size, label:
                            Text("Coffee Size")) {
                            ForEach (sizes, id: \.self) {
                                Text($0)
                            }
                        } .pickerStyle(SegmentedPickerStyle())
                    }
                    
                    // section that contains quantity of coffee cups
                    Section(header: Text("How many cups?")) {
                        // text field for user to enter coffee cup quantity
                        TextField("Enter quantity", text: $quantity)
                            .padding(10)
                            .keyboardType(.numberPad)
                    }
                    
                    HStack() {
                        
                        Spacer()
                        
                        // button to submit coffee order
                        Button(action: {
                            
                            // checks if quantity is entered
                            if (self.validateEmptyData()){
                                
                                self.addNewCoffee()
                                
                                self.alertTitle = "Order Placed"
                                self.alertMessage = "Coffee order has been placed"
                                self.invalidOrder = true
                             
                            }
                            else {
                                // if quantity not entered, alerts user
                                self.alertTitle = "Error"
                                self.alertMessage = "Coffee quantity is required"
                                self.invalidOrder = true
                            }
                            
                        }, label: {
                            // sets label for button
                            Text("Order")
                                .foregroundColor(Color.white)
                                .fontWeight(.bold)
                                .font(.body)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 10)
                        })
                            .background(Color(red: 173/255, green: 150/255, blue: 134/255))
                            .cornerRadius(10)
                            .alert (isPresented: self.$invalidOrder){
                                // sets text of the alert message and the dismiss button
                                Alert(
                                    title: Text(self.alertTitle),
                                    message: Text(self.alertMessage),
                                    dismissButton: .default(Text("Ok"))
                                )
                            }
                        
                        Spacer()
                        
                    } //HStack
                    .listRowBackground(Color.clear)
                    
                } //Form
                
                // adds a title to navigation bar
                .navigationBarTitle("My Order", displayMode: .inline)
                
                // adds button to navigation bar
                .toolbar {
                    Button("Orders") {
                        self.selection = 1
                    }
                    .foregroundColor(Color(red: 173/255, green: 150/255, blue: 134/255))
                }
                
            }
        } // NavigationView
        
    } // Body View
    
    // function that checks if coffee quantity has been entered
    private func validateEmptyData() -> Bool{
        if (self.quantity.isEmpty){
            return false
        }
        return true
    }
    
    private func addNewCoffee(){
        self.coreDBHelper.insertTask(coffee: Coffee(cFlavour: self.flavour, cSize: self.size, cQuantity: self.quantity))
        self.presentationMode.wrappedValue.dismiss()
    }
    
} //View


struct coffeeOrder_Previews: PreviewProvider {
    static var previews: some View {
        coffeeOrder()
    }
}
