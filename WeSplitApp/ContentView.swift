//
//  ContentView.swift
//  WeSplitApp
//
//  Created by Crittenden, Rey  on 2/5/20.
//  Copyright © 2020 Crittenden, Rey . All rights reserved.
//
//NOTE: STOPPED AT CALC THE TOTAL PER PERSON

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = ""//This has to be String because TextField only accepts String
    @State private var numberOfPeople = 2//Temp people
    @State private var tipPercentage = 2//Temp tip percent
    let tipPercentages = [0, 10, 15, 20, 25]
    
    var body: some View {
        NavigationView{//The Form has constricted the Picker, meaning that it expects the Picker menu to be sent to a new View. NavigationView allows the use of additional views.
            Form{
                Section{
                    TextField("Amount: ", text: $checkAmount)//Insert total cost; note that @State re-invokes (reloads) the UI automatically the moment the value/textfield is changed
                        .keyboardType(.decimalPad)//Conforms the TextField to use the decimal pad for typing
                    Picker("Number of People: ", selection: $numberOfPeople){
                        ForEach(2 ..< 100){//From 2 people to 100
                            Text("\($0) people")//Note: $0 is the value inside the ForEach(...){}
                        }
                        
                    }
                }
                
                Section{
                    Text("$\(checkAmount)")
                }
                
                Section(header: Text("Select Tip Percent")){//"header" allows the labelling of that particular section
                    Picker("Tip Percentage: ", selection: $tipPercentage){
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
