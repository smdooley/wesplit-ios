//
//  ContentView.swift
//  WeSplit
//
//  Created by Sean Dooley on 28/10/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = [10, 15, 20, 25, 0]
    var grandTotal: Double {
        let tipSelection = Double(tipPercentage)

        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        
        return grandTotal
    }
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        //let tipSelection = Double(tipPercentage)

        //let tipValue = checkAmount / 100 * tipSelection
        //let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount

        return amountPerPerson
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField(
                        "Amount",
                        value: $checkAmount,
                        format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    .keyboardType(.decimalPad)
                    .focused($amountIsFocused)
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                    //.pickerStyle(.navigationLink)
                }
                
                Section("How much tip do you want to leave?") {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        /*ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }*/
                        ForEach(0..<101) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                
                Section("Amount per person") {
                    Text(
                        totalPerPerson,
                        format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    
                }
                
                Section("Grand total") {
                    Text(grandTotal, format: .currency(code: Locale.current.currency?.identifier ?? "USD")
                    )
                    .foregroundColor(tipPercentage == 0 ? .red : .primary)
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                if(amountIsFocused) {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
