//
//  ContentView.swift
//  WeSplit
//
//  Created by Adam Herman on 08/01/2026.
//

import SwiftUI

struct ContentView: View {
    
    @State private var billAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var isAmountFocused: Bool
    
    let tipPercentages: [Int] = [5, 10, 15, 20, 25]
    
    var totalPerPeson: Double{
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        let tipValue = billAmount / 100 * tipSelection
        let grandTotal = billAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount

        return amountPerPerson
    }
    
    var body: some View {
        VStack {
            NavigationStack {
                Form {
                    Section("Enter Bill Amount:"){
                        TextField("Enter bill amount", value: $billAmount, format: .currency(code: Locale.current.currency?.identifier ?? "PLN"))
                            .keyboardType(.numberPad)
                            .focused($isAmountFocused)
                    }
                    Section("Each has to pay:") {
                        Text(totalPerPeson, format: .currency(code: Locale.current.currency?.identifier ?? "PLN"))
                    }
                    Picker("Choose amount of people", selection: $numberOfPeople){
                        ForEach(2..<100){
                            Text("\($0) people")
                        }
                    }.pickerStyle(.navigationLink)
                    Section("How much tip would you like to leave?"){
                        Picker("Tip Percentage", selection: $tipPercentage){
                            ForEach(tipPercentages, id: \.self){
                                Text($0, format: .percent)
                            }
                        }.pickerStyle(.segmented)
                    }
                }
                .navigationTitle("WeSplit")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar{
                    if isAmountFocused{
                        Button("Done"){
                            isAmountFocused = false
                        }
                    }
                }
            }
        }
        .background(Color.white)
        .padding()
    }
}

#Preview {
    ContentView()
}
