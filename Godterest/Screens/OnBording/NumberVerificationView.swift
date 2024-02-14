//
//  NumberVerificationView.swift
//  Godterest
//
//  Created by Gaganpreet Singh on 1/17/24.
//

import SwiftUI
import iPhoneNumberField

struct NumberVerificationView: View {
    @EnvironmentObject var CreateAccountVM : QuestionsVM
  @State private var text: String = ""
    @FocusState private var isFocused: Bool
    var body: some View {
       
        VStack{
            BackButton().padding(.top)
            Spacer(minLength: 20)
            ScrollView {
                VStack(alignment: .center,spacing: 20 ) {

                    VStack(alignment: .leading,spacing: 20 ) {
                        Text("What’s your number?")
                            .fontWeight(.heavy)
                            .foregroundColor(Color.primary)
                            .font(.custom("Avenir", size: 22))
                        HStack {
                          
                          iPhoneNumberField( text: $CreateAccountVM.mobileNumber, formatted: true)
                            .clearButtonMode(.whileEditing)
                            .flagHidden(false)
                            .flagSelectable(true)
                            .prefixHidden(false)
                            .focused($isFocused)
                            .onChange(of: CreateAccountVM.mobileNumber) { oldValue, newValue in
                                print("Changing from \(oldValue) to \(newValue)")
                            }
                            .font(.custom("Avenir", size: 16))
                            .frame(height: 60)
                            .keyboardType(.numberPad)
                          
//                          TextField("Enter number", text: $CreateAccountVM.mobileNumber.max(10))
//                            .onChange(of: CreateAccountVM.mobileNumber) { oldValue, newValue in
//                                print("Changing from \(oldValue) to \(newValue)")
//                            }
//                            .font(.custom("Avenir", size: 16))
//                            .frame(height: 60)
//                            .keyboardType(.numberPad)
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
            CustomButton(ButtonTitle: "Verify", ButtonType: .mobileNumber ,View: AnyView(VerifyView()), fontSize: 22).cornerRadius(30).padding(.all)
            Spacer()
            
        }.navigationBarBackButtonHidden()
        .background( Color(Color("App Background")))
        .onAppear {
            isFocused = true
        }
    }
}

#Preview {
    NumberVerificationView().environmentObject(QuestionsVM())
    
  //  VerifyView().environmentObject(QuestionsVM())
}


struct VerifyView: View {
    @EnvironmentObject var CreateAccountVM : QuestionsVM
   
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
                        
                        Text("Enter the code we've sent by text to \(CreateAccountVM.mobileNumber)")
                            .frame(width: 260)
                            .multilineTextAlignment(.leading)
                            
                        HStack {
                          
                          TextField("", text: $CreateAccountVM.otp.max(4))
                            .onChange(of: CreateAccountVM.otp) { oldValue, newValue in
                                print("Changing from \(oldValue) to \(newValue)")
                            }
                            .font(.custom("Avenir", size: 16))
                                .keyboardType(.numberPad)
                        }.padding().frame(height: 60).background(RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(.white))
                        Spacer()
                    }.padding(.horizontal ,20)
                }.padding(0)
            }
           
            CustomButton(ButtonTitle: "Verify", ButtonType: .otp ,View: AnyView(NameView()), fontSize: 22).cornerRadius(30).padding(.all)
            Spacer()
            
        }.background( Color(Color("App Background")))
    }
}


