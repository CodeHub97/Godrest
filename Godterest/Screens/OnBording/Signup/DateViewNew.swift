//
//  DateViewNew.swift
//  Godterest
//
//  Created by 🙂 Kuldeep 🙂 on 2024-01-16.
//

import SwiftUI

struct DateViewNew:View{
    @EnvironmentObject var CreateAccountVM : QuestionsVM
    
    @State private var Age = 0
    
    var body: some View {
        VStack{
            BackButton().padding(.top,30)
            
            VStack(alignment: .center,spacing: 20 ) {
                VStack(alignment: .leading,spacing: 20 ) {
                    Text("What is your date of birth?").fontWeight(.bold).foregroundColor(Color.primary).font(.custom("Avenir", size: 30))
                    
                    DatePicker(
                        "", selection: $CreateAccountVM.dateofBirth,
                        in: ...Date(),
                        displayedComponents: [.date]
                    ).datePickerStyle(.wheel).accentColor(.teal)
                        .onChange(of: CreateAccountVM.calculateAge(birthdate: CreateAccountVM.dateofBirth)) { newValue in
                            Age = newValue
                        }
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(color: Color(red: 250, green: 250, blue: 250),  radius:1)
                    Text("You’re \(Age) years old").fontWeight(.regular).foregroundColor(Color.primary).font(.custom("Avenir", size: 20))
                    Spacer()
                    CustomButtonOnboarding(ButtonTitle: "Update", ButtonType: .dateofBirth ,View: AnyView(ProfilePictureView())).padding(.vertical)
                }.padding(.horizontal ,10)
            }.padding(20)
            Spacer()
        }.background(Color("App Background"))
    }
}

#Preview {
    DateViewNew().environmentObject(QuestionsVM())
}
