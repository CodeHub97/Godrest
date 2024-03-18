//
//  AccountSetup.swift
//  Godterest
//
//  Created by Gaganpreet
//

import SwiftUI

struct LoginNew: View {
    @ObservedObject var LoginViewModel = LoginVM()
    @Environment(\.isLoggedIn) var isLoggedIn
    
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
                          
                            TextField("", text: $LoginViewModel.mobileNumber).font(.custom("Avenir", size: 16))
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
           // CustomButton(ButtonTitle: "Login", ButtonType: .mobileNumber ,View: AnyView(VerifyView(userId: 34)), fontSize: 22)
            
            CustomButton3(ButtonTitle: "Login", ButtonType: .mobileNumber) {
                UIApplication.shared.endEditing()
                LoginViewModel.hitSignIN()
               
            }
                .cornerRadius(30).padding(.all)
            Spacer()
            
        }.navigationBarBackButtonHidden()
        .background( Color(Color("App Background")))
        
        
        .navigationDestination(isPresented: $LoginViewModel.LoginapiCompleted , destination: {
            TabbarScreen().environment(\.isLoggedIn, true)
        })
    
        .toast(isPresenting: $LoginViewModel.showToast){
            AlertToast(displayMode: AlertToast.DisplayMode.alert, type: .regular, title: LoginViewModel.ErrorType == .LoginAPI ? LoginViewModel.errorMessage : LoginViewModel.ErrorType.errorMessage)
        }
        .overlay{
          if !LoginViewModel.LoginapiLoaded{
            ProgressView("Login...").padding(.horizontal , 80).padding(.vertical , 30).background(RoundedRectangle(cornerRadius: 20).fill(Material.ultraThinMaterial).opacity(0.7))
          }
        }
    }
}


#Preview {
  LoginNew()
}
