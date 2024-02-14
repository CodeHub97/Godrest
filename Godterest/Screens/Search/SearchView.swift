//
//  SearchView.swift
//  Godterest
//
//  Created by Varjeet Singh on 13/09/23.
//

import SwiftUI

struct SearchView: View {
  @State var AgeStart = ""
  @State var AgeEnd = ""
  @State private var value = 0.0
  @State var sliderPosition: ClosedRange<Float> = 3...8
  let points = [0.0, 20.0, 30.0, 40.0]
    var body: some View {
      VStack{
        ZStack(alignment: .center) {
          BackButton()
          AddText(TextString: "Filter", TextSize: 20,FontWeight: .medium,Alignment: .center)

          Text("clear all").font(.custom("Avenir", size: 18)).foregroundStyle(LinearGradient(colors: [Color("App Red"),Color("App Yellow")], startPoint: .leading, endPoint: .trailing)).frame(maxWidth: .infinity,alignment: .trailing).padding(.trailing)
        }.padding(.top)

        HStack{
          AddText(TextString: "Filter profile by", TextSize: 18)
          Spacer()
          Image("Filterer")
        }.padding(.horizontal,30)

        AddText(TextString: "Age", TextSize: 18).frame(maxWidth: .infinity,alignment: .leading).padding(.leading,30)

        HStack{
          TextField("25", text: $AgeStart).padding()
            .background(Capsule().foregroundColor(.gray.opacity(0.2)))
                      .fontWeight(.regular).font(.custom("Avenir", size: 16)).foregroundColor(Color.black)
          TextField("125", text: $AgeEnd).padding()
            .background(Capsule().foregroundColor(.gray.opacity(0.2)))
                      .fontWeight(.regular).font(.custom("Avenir", size: 16)).foregroundColor(Color.black)
               
        }.padding(.horizontal,30)
        VStack {
          Text("Value: " + value.description)


                    //Slider
          RangedSliderView(value: $sliderPosition, bounds: 1...10).padding().frame(height: 50)
          HStack {
            AddText(TextString: "MIN", TextSize: 12,Color: .gray, FontWeight: .medium)
            Spacer()
            AddText(TextString: "MAX", TextSize: 12,Color: .gray, FontWeight: .medium)
          }
          .padding(.horizontal,30)
          .padding(.vertical,15)
                }
        AddText(TextString: "Distance (miles)", TextSize: 18).frame(maxWidth: .infinity,alignment: .leading).padding(.leading,30)
        Slider(value: $value, in: 0...40, step: 10) {
                        Text("Slider")
        }.padding().accentColor(.red).foregroundColor(.green)
        VStack {
          AddText(TextString: "Advanced filter", TextSize: 18).frame(maxWidth: .infinity,alignment: .leading).padding(.leading,30)
          AddText(TextString: "Choose onr additional filter to make your search more precise.", TextSize: 15,Color: .gray).frame(maxWidth: .infinity,alignment: .leading).padding(.leading,30)
        }

        Divider()
        Spacer()
      }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}


