//
//  ContentView.swift
//  SimpleBMICalc
//
//  Created by Emmanuel Begahh on 03/02/2023.
//

import SwiftUI

struct ContentView: View {
    
    @State private var heightInput: String = "1.0"
    @State private var weightInput: String = "1.0"
    
    @State var bmiText: String = ""
    @State var bmiDetail: String = ""
    @State var bmiString: String = ""
    
    @State var showAlert: Bool = false
    
    @State var height: Float = 0.0
    @State var weight: Float = 0.0
    @State var isChanged = false
    
    
    var body: some View {
        
        ZStack {
            VStack {
                VStack {
                    VStack {
                        // Title Section
                        VStack {
                            Text("Body Mass Index (BMI) Calculator")
                                .font(.largeTitle)
                                .multilineTextAlignment(.center)
                                .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                                .foregroundColor(.black)
                                .underline()
                        }
                        .background(Color.gray)
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 300)
                        
                        // Textfields and Sliders
                        VStack {
                            TextField("Enter height in meters - 1.65", text: $heightInput)
                                .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                                .frame(width: 300.0)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .background(Color.clear)
                                .foregroundColor(Color.black)
                                .shadow(radius: 5)
                                .keyboardType(/*@START_MENU_TOKEN@*/.decimalPad/*@END_MENU_TOKEN@*/)
                            .onChange(of: heightInput) { value in calculateBMI()}
                            
                            //add SLIDER ADDED
                            Slider(value: $height, in: 1...3, onEditingChanged: { _ in
                                if self.isChanged == false { self.isChanged = true }
                                
                                heightInput = String(format: "%.2f", height)
                            })
                            .padding(.horizontal, 30.0)
                            
                            
                            TextField("Enter weight in kilograms - 65", text: $weightInput)
                                .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                                .frame(width: 300.0)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .background(Color.clear)
                                .foregroundColor(Color.black)
                                .shadow(radius: 5)
                                .keyboardType(/*@START_MENU_TOKEN@*/.decimalPad/*@END_MENU_TOKEN@*/)
                            .onChange(of: weightInput) { value in calculateBMI()}
                            
                            //adding slider
                            Slider(value: $weight, in: 1...200, onEditingChanged: { _ in
                                if self.isChanged == false { self.isChanged = true }
                                
                                weightInput = String(format: "%.2f", weight)
                            })
                            .padding(.horizontal, 30.0)
                            
                            
                        }
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                        
                        // Results section
                        VStack {
                            Text(bmiText)
                                .font(.title)
                                .foregroundColor(Color.black)
                                .multilineTextAlignment(.center)
                            Text(bmiString)
                                .font(.title)
                                .foregroundColor(Color.black)
                                .multilineTextAlignment(.center)
                            Text(bmiDetail)
                                .font(.caption)
                                .foregroundColor(Color.black)
                                .multilineTextAlignment(.center)
                                .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                        }
                        .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                        
                    }
                    
                    // Button View
                    HStack {
                        Button {
                            //calculateBMI()
                        }
                        
                    label:{
                        HStack {
                            Text("Calculate BMI")
                                .foregroundColor(Color.black)
                                .multilineTextAlignment(.center)
                                .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                                .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.blue/*@END_MENU_TOKEN@*/)
                        }
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .font(.title2)
                        .padding(.horizontal, 60.0)
                        .padding(.vertical, 20.0)
                        .background(Color("button"))
                        .cornerRadius(10)
                        .foregroundColor(Color.cyan)
                        .shadow(radius: 5)
                        .padding(.vertical, 40)
                        .padding(.horizontal, 20)
                        
                        
                        // add the remaining mdoifiers
                    }
                        
                    .alert(isPresented: $showAlert) {
                        Alert(title: Text("Invalid Data"), message: Text("Non-numeric or missing data"), dismissButton: .default(Text("Try Again"))) }
                        
                    }
                    
                }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                
                .edgesIgnoringSafeArea(.all)
                
            }
        }
        .background(Color.yellow)
        
        
    }
    
    // Validation and calculation
    
    func calculateBMI() {
        if self.heightInput == "" || self.weightInput == "" {
            self.showAlert = true
            return
        }
        
        let numberPattern = #"^\d{1,5}|\d{0,5}\.\d{1,2}$"#
        let result = self.heightInput.ranges(of: numberPattern)
        let validHeight = (result != nil)
        
        if (!validHeight) {
            self.showAlert = true
            return
        }
        
        let heightInMeters = Double(self.heightInput)
        
        let weightInKG = Double(self.weightInput)
        
        let heightInMetersSqrd = pow(heightInMeters!, 2)
        
        let bmis = weightInKG!/heightInMetersSqrd
        let bmi2dp = Double(round(100 * bmis) / 100)
        self.bmiString = " \(bmi2dp)"
        
        self.bmiText = "Your BMI is"
        
        if bmis > 30 {
            self.bmiDetail = "You are classified as Obese."
        }
        else if bmis > 25 {
            self.bmiDetail = "You are classified as Overweight."
        }
        else {
            self.bmiDetail = "You are Healthy!"
        }
        
        
    }
    
}
    

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
