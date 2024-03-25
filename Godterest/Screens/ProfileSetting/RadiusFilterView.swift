//
//  RadiusFilterView.swift
//  Godterest
//
//  Created by Gaganpreet Singh on 3/23/24.
//

import SwiftUI


struct RadiusFilterView: View {
    
    @State var sliderValue: Double = .zero
    var minValue: Double = 10
    var maxValue: Double = 100
    
    
    var body: some View {
        VStack(spacing: 30 ) {
            VStack {
                ZStack(alignment: .center) {
                    BackButton()
                    AddText(TextString: "Distance filter", TextSize: 20,FontWeight: .medium,Alignment: .center)
                }.padding(.top)
                Divider().offset(y: 8)
            }
            
            
            Image("pin")
                .resizable()
                .frame(width: 100, height: 100, alignment: .bottom)
            
            VStack(alignment: .leading, spacing: 50){
               
                HStack {
                    
                    Text("10 km")
                  
                   
                    Slider(value: $sliderValue, in: 10...100, step: 1)
                        .alignmentGuide(VerticalAlignment.center) { $0[VerticalAlignment.center]}
                        .padding(.top)
                        .frame(height: 80)
                        .accentColor(.red)
                    
                        .overlay(GeometryReader { gp in
                            VStack (alignment: .center, spacing: 50){
                                Text("\(sliderValue,specifier: "%.f")")
                                    .foregroundColor(.red)
                                    .alignmentGuide(HorizontalAlignment.leading) {
                                        print("Hii \(sliderValue) $0.width: \($0.width)")
                                        print("value \(sliderValue)")
                                        return $0[HorizontalAlignment.leading] - (gp.size.width - $0.width) * (sliderValue - minValue) / ( maxValue - minValue)
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                            }
                        }, alignment: .top)
                    
                    Text("100 km")
                }.padding(5)
            }
            .onChange(of: sliderValue) {
                UserSettings.shared.radiusDistance = sliderValue
            }
            
            Spacer()
            
        }
            .navigationBarBackButtonHidden()
            .onAppear(perform: {
                self.sliderValue = UserSettings.shared.radiusDistance
            })
    }
    
}

#Preview {
    RadiusFilterView()
}
