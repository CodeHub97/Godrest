//
//  AccountSetup.swift
//  Godterest
//
//  Created by Gaganpreet
//

import SwiftUI

struct LoginNew: View {
    @EnvironmentObject var CreateAccountVM : QuestionsVM
   
    var body: some View {
       
        VStack{
            BackButton().padding(.top)
            Spacer(minLength: 20)
            ScrollView {
                VStack(alignment: .center,spacing: 20 ) {

                    VStack(alignment: .leading,spacing: 20 ) {
                        Text("Login with mobile number")
                            .fontWeight(.heavy)
                            .foregroundColor(Color.primary)
                            .font(.custom("Avenir", size: 22))
                        HStack {
                          
                            TextField("", text: $CreateAccountVM.mobileNumber).font(.custom("Avenir", size: 16))
                                .frame(height: 60)
                           
                                .keyboardType(.numberPad)
                        }.padding().frame(height: 60).background(RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(.white))
                        Spacer()
                    }.padding(.horizontal ,20)
                }.padding(0)
            }
            Text("We never share this with anyone. It won't be on your profile.")
                .frame(width: 250)
                .multilineTextAlignment(.center)
                .foregroundColor(.gray)
                .padding(-10)
            CustomButton(ButtonTitle: "Login", ButtonType: .mobileNumber ,View: AnyView(VerifyView(userId: 34)), fontSize: 22).cornerRadius(30).padding(.all)
            Spacer()
            
        }.navigationBarBackButtonHidden()
        .background( Color(Color("App Background")))
    }
}


#Preview {
  LoginNew()
}
