//
//  VerifyView.swift
//  Godterest
//
//  Created by Offsureit Solutions on 21/03/24.
//

import SwiftUI

struct VerifyView: View {
  @EnvironmentObject var CreateAccountVM : QuestionsVM
  @EnvironmentObject var LoginViewModel: LoginVM
  
 // @State var userId: Int
  @State var verify: VerifyType
  
  enum VerifyType {
    case signup
    case login
  }
  
  init( verify: VerifyType = .signup) {
    //self.userId = userId
    self.verify = verify
  }
  var body: some View {
    VStack{
         BackButton().padding(.top)
      Spacer(minLength: 20)
      ScrollView {
        VStack(alignment: .center, spacing: 20 ) {
          
          VStack(alignment: .leading,spacing: 20 ) {
            Text("Verify your number")
              .fontWeight(.heavy)
              .foregroundColor(Color.primary)
              .font(.custom("Avenir", size: 22))
            
            Text("Enter the code we've sent by text to \(verify == .login ? LoginViewModel.mobileNumber : CreateAccountVM.mobileNumber)")
              .frame(width: 260)
              .multilineTextAlignment(.leading)
            
            HStack {
              
              TextField("", text: $CreateAccountVM.otp.max(6))
                .onChange(of: CreateAccountVM.otp) { oldValue, newValue in
                  print("Changing from \(oldValue) to \(newValue)")
                }
                .font(.custom("Avenir", size: 16))
                .keyboardType(.numberPad)
                .foregroundColor(.black)
            }.padding()
              .frame(height: 60)
              .background(RoundedRectangle(cornerRadius: 10)
                .foregroundColor(.white))
            Spacer()
          }.padding(.horizontal ,20)
        }.padding(0)
      }
      
      CustomButton3(ButtonTitle: "Verify", ButtonType: .otp) {
        UIApplication.shared.endEditing()
        
        switch verify {
        case .login:
          LoginViewModel.login(withOtp: CreateAccountVM.otp)
          break
        case .signup:
          CreateAccountVM.VerifyUser() {
            
          }
          break
        }
        
      }.cornerRadius(30).padding(.all)
      Spacer()
      
    }.background( Color(Color("App Background")))
      .navigationBarBackButtonHidden()
      .navigationDestination(isPresented: verify == .login ? $LoginViewModel.otpVerified : $CreateAccountVM.otpVerified , destination: {
          switch verify {
          case .signup:
              NameView().navigationBarBackButtonHidden()
  
          case .login:
              TabbarScreen().environment(\.isLoggedIn, true)
           
          }
          
       
      })
      .disabled((verify == .login ? LoginViewModel.otpVerificationStart : CreateAccountVM.otpVerificationStart))
      .toast(isPresenting: verify == .login ? $LoginViewModel.showToast : $CreateAccountVM.showToast){
        AlertToast(displayMode: AlertToast.DisplayMode.alert, type: .regular, title:  CreateAccountVM.errorMessage)
        
      }
      .overlay{
        if (verify == .login ? LoginViewModel.otpVerificationStart : CreateAccountVM.otpVerificationStart){
          ProgressView("Verifing...").padding(.horizontal , 80).padding(.vertical , 30).background(RoundedRectangle(cornerRadius: 20).fill(Material.ultraThinMaterial).opacity(0.7))
        }
      }
  }
}

#Preview {
  VerifyView().environmentObject(QuestionsVM())
}
