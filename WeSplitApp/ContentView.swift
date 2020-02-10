//
//  ContentView.swift
//  WeSplitApp
//
//  Created by Crittenden, Rey  on 2/5/20.
//  Copyright © 2020 Crittenden, Rey . All rights reserved.

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = ""//This has to be String because TextField only accepts String
    @State private var amountOfPeople = ""
    //@State private var numberOfPeople = 2//Temp people
    @State private var tipPercentage = 2//Temp tip percent, represents an index
    let tipPercentages = [0, 10, 15, 20, 25]
    
    var grandTotal: Double {
        let tipSelection = Double(tipPercentages[tipPercentage])
        var orderAmount = Double(checkAmount) ?? 0
        if orderAmount < 0 {orderAmount = 0}
        let tipValue = orderAmount / 100 * tipSelection
        let totalCost = orderAmount + tipValue
        return totalCost
    }
    
    var totalPerPerson: Double {//A computed property
        //let peopleCount = Double(numberOfPeople + 2)//Counts from 0, so we need to add 2
        let people = Double(amountOfPeople) ?? 1
        var peopleCount = Int(people)//Cannot be 0, has been set to var
        if peopleCount <= 0 {peopleCount *= -1}
        if peopleCount > (10000000) {peopleCount = 1}
        let tipSelection = Double(tipPercentages[tipPercentage])
        var orderAmount = Double(checkAmount) ?? 0//"?": if the string can't be converted to a double, it converts the string to 0
        if orderAmount < 0 {orderAmount = 0}
        let tipValue = orderAmount / 100 * tipSelection
        let grandTotal = orderAmount + tipValue
        let amountPerPerson = grandTotal / Double(peopleCount)
        /*
         let stringValue = "0.5"
         let doubleValue = Double(stringValue)//Converts a string to a double
         */
        return amountPerPerson//How much a single person pays, divided evenly
    }
    
    var body: some View {
        NavigationView{//The Form has constricted the Picker, meaning that it expects the Picker menu to be sent to a new View. NavigationView allows the use of additional views.
            Form{
                Section{
                    TextField("Amount: ", text: $checkAmount)//Insert total cost; note that @State re-invokes (reloads) the UI automatically the moment the value/textfield is changed
                        .keyboardType(.decimalPad)//Conforms the TextField to use the decimal pad for typing
                    TextField("Number of People: ", text: $amountOfPeople)
                        .keyboardType(.decimalPad)
                    /*Picker("Number of People: ", selection: $numberOfPeople){
                     ForEach(2 ..< 100){//From 2 people to 100
                     Text("\($0) people")//Note: $0 is the value inside the ForEach(...){}
                     }
                     
                     }*/
                }
                
                Section(header: Text("Total Cost (including tip): ")){
                    Text("$\(grandTotal, specifier: "%.2f")")//Foramats the double totalPerPerson to 2 decimals
                }
                
                Section(header: Text("Amount Per Person")){
                    Text("$\(totalPerPerson, specifier: "%.2f")")//Foramats the double totalPerPerson to 2 decimals
                }
                
                Section(header: Text("Select Tip Percent")){//"header" allows the labelling of that particular section
                    Picker("Tip Percentage: ", selection: $tipPercentage){//The selection in the app changes the value to the index of the selection
                        ForEach(0 ..< tipPercentages.count){//From 0 the highest index of tipPercentages
                            Text("\(self.tipPercentages[$0])")//"self." is suggested as a fix if not used
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
/*
 Notes:
 "$" is called a two-way binding that allows it to be modified AND printed in the same moment
 */
