//
//  GenderSelectionView.swift
//  Godterest
//
//  Created by Gaganpreet Singh on 1/20/24.
//

import SwiftUI

struct GenderSelectionView: View {
    @EnvironmentObject var CreateAccountVM : QuestionsVM
    @State private var textInput: String = ""
    @State private var selectedIndex: Int = 0
    private var list:[String] = ["Male", "Female"]
    
    var body: some View {
         
        
        VStack{
            BackButton().padding(.top)
            
            VStack(alignment: .leading, spacing: 10 ) {
                Text("What gender are you?")
                    .multilineTextAlignment(.leading)
                    .fontWeight(.heavy)
                    .foregroundColor(Color.primary)
                    .font(.custom("Avenir", size: 30))
                
                
            }.padding(.horizontal ,10)
            
            List(0..<list.count, id: \.self) { index in
                
                HStack {
                    Text(list[index]).frame(maxWidth: .infinity,alignment:.leading)
                        .fontWeight(.medium)
                        .font(.custom("Avenir", size: 20)).foregroundColor(Color.primary)
                        
                    
                    Spacer()
                    if selectedIndex == index {
                        Image("ic_checked").frame(width: 25, height: 25, alignment: .center)
                            .aspectRatio(contentMode: .fill)
                            
                    }else {
                        Image("ic_uncheck").frame(width: 25, height: 25, alignment: .center)
                            .aspectRatio(contentMode: .fill)
                            
                    }
                }.onTapGesture {
                    
                    self.selectedIndex = index
                    
                }.listRowSeparator(.hidden)
                    .listRowInsets(.init(top: 5, leading: 15, bottom: 5, trailing: 15))
                    .listRowBackground(Color("App Background"))

                .frame(maxWidth: .infinity,alignment:.leading).padding().background(RoundedRectangle(cornerRadius: 12).stroke(lineWidth: 2)
                  .foregroundStyle(
                    LinearGradient(
                      colors: [ Color.gray.opacity(0.25),
                                Color.gray.opacity(0.25)],
                      startPoint: .leading,
                      endPoint: .trailing
                    )
                  )
                )
                .background(Color.white)
                .cornerRadius(12)
                
            }.listStyle(.plain).background(Color("App Background"))
                .listRowSeparator(.hidden)
                    .listRowInsets(.init(top: 5, leading: 0, bottom: 5, trailing: 0))
                   
                   
            Spacer()
            VStack {
                CustomButton(ButtonTitle: "Update", ButtonType: .GenderSelect ,View: AnyView(DateViewNew()), fontSize: 22).cornerRadius(30).padding(.all)
               
            }
        }.background( Color(Color("App Background")))
        
        
    }
}

#Preview {
    GenderSelectionView().environmentObject(QuestionsVM())
}
