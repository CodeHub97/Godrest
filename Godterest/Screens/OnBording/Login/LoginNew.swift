//
//  AccountSetup.swift
//  Godterest
//
//  Created by Gaganpreet
//

import SwiftUI
import Combine
struct LoginNew: View {
 // @ObservedObject var LoginViewModel = LoginVM()
  @EnvironmentObject var LoginViewModel: LoginVM
  @Environment(\.isLoggedIn) var isLoggedIn
  
  
  //Textfield
  @State var presentSheet = false
  @State var countryCode : String = "+91"
  @State var countryFlag : String = "🇮🇳"
  @State var countryPattern : String = "### ### ####"
  @State var countryLimit : Int = 17
  @State var mobPhoneNumber = ""
  @State private var searchCountry: String = ""
  @State private var userId: Int = 0
  
  @FocusState private var keyIsFocused: Bool
  
  let counrties: [CPData] = Bundle.main.decode("CountryNumbers.json")
  
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
              
              
              Button {
                presentSheet = true
                keyIsFocused = false
              } label: {
                Text("\(countryFlag) \(countryCode)")
                  .padding(0)
                  .frame(minWidth: 70, minHeight: 60)
                  .background(Color.white, in: RoundedRectangle(cornerRadius: 10, style: .continuous))
                  .foregroundColor(Color.black)
              }.background(Color.white)
              
              TextField("", text: $LoginViewModel.mobileNumber)//.font(.custom("Avenir", size: 16))
                .frame(height: 60)
                .placeholder(when: LoginViewModel.mobileNumber.isEmpty) {
                  Text("Phone number")
                    .foregroundColor(.secondary)
                }
              
                .keyboardType(.numberPad)
              
                .focused($keyIsFocused)
              
                .onReceive(Just($LoginViewModel.mobileNumber)) { _ in
                  applyPatternOnNumbers(&mobPhoneNumber, pattern: countryPattern, replacementCharacter: "#")
                }
              
            }.padding().frame(height: 60)
              .background(RoundedRectangle(cornerRadius: 10)
                .foregroundColor(.white))
            
              .onTapGesture {
                hideKeyboard()
              }
              .sheet(isPresented: $presentSheet) {
                NavigationView {
                  List(filteredResorts) { country in
                    HStack {
                      Text(country.flag)
                      Text(country.name)
                        .font(.headline)
                      Spacer()
                      Text(country.dial_code)
                        .foregroundColor(.secondary)
                    }
                    .onTapGesture {
                      self.countryFlag = country.flag
                      self.countryCode = country.dial_code
                      self.countryPattern = country.pattern
                      self.countryLimit = country.limit
                      presentSheet = false
                      searchCountry = ""
                      LoginViewModel.countryCode = country.dial_code
                    }
                  }
                  .listStyle(.plain)
                  .searchable(text: $searchCountry, prompt: "Your country")
                }
                .presentationDetents([.medium, .large])
              }
              .presentationDetents([.medium, .large])
            
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
      
      //          CustomButton3(ButtonTitle: "Login", ButtonType: .mobileNumber, buttonfor: .login) {
      //                UIApplication.shared.endEditing()
      //                LoginViewModel.hitSignIN()
      //
      //            }
      //
      var isDisabled: Bool {
        return LoginViewModel.mobileNumber.count < 10
      }
      
      
      Button {
        UIApplication.shared.endEditing()
        LoginViewModel.hitSendOtp()
      } label: {
        HStack{
          Spacer()
          Text("Login")
            .fontWeight(.medium)
            .foregroundColor(Color.white)
            .font(.custom("Avenir", size: CGFloat(18)))
          
          Spacer()
        }.frame( height: 60, alignment: .center)
          .background(RoundedRectangle(cornerRadius: 10)).foregroundStyle(LinearGradient(colors: [ !(isDisabled ?? false) ? Color("App Red"): Color.gray , !(isDisabled ?? false) ? Color("App Yellow")  : Color.gray], startPoint: .leading, endPoint: .trailing)
          )
      }
      
      
      
      .cornerRadius(30).padding(.all)
      Spacer()
      
    }.navigationBarBackButtonHidden()
      .background( Color(Color("App Background")))
    
    
      .navigationDestination(isPresented: $LoginViewModel.LoginapiCompleted , destination: {
       // TabbarScreen().environment(\.isLoggedIn, true)
        
        VerifyView(verify: .login)
        
      })
      
      .disabled(!LoginViewModel.LoginapiLoaded)
    
      .toast(isPresenting: $LoginViewModel.showToast){
        AlertToast(displayMode: AlertToast.DisplayMode.alert,
                   type: .regular,
                   title: LoginViewModel.ErrorType == .LoginAPI ? LoginViewModel.errorMessage : LoginViewModel.ErrorType.errorMessage)
      }
      .overlay{
        if !LoginViewModel.LoginapiLoaded{
          ProgressView("Login...").padding(.horizontal , 80).padding(.vertical , 30).background(RoundedRectangle(cornerRadius: 20).fill(Material.ultraThinMaterial).opacity(0.7))
        }
      }
    
      .onAppear {
        
        LoginViewModel.countryCode = countryCode
      }
  }
}

extension LoginNew {
  
  var filteredResorts: [CPData] {
    if searchCountry.isEmpty {
      return counrties
    } else {
      return counrties.filter { $0.name.contains(searchCountry) }
    }
  }
  
  func applyPatternOnNumbers(_ stringvar: inout String, pattern: String, replacementCharacter: Character) {
    var pureNumber = stringvar.replacingOccurrences( of: "[^0-9]", with: "", options: .regularExpression)
    for index in 0 ..< pattern.count {
      guard index < pureNumber.count else {
        stringvar = pureNumber
        return
      }
      let stringIndex = String.Index(utf16Offset: index, in: pattern)
      let patternCharacter = pattern[stringIndex]
      guard patternCharacter != replacementCharacter else { continue }
      pureNumber.insert(patternCharacter, at: stringIndex)
    }
    stringvar = pureNumber
  }
}


#Preview {
  LoginNew()
}
