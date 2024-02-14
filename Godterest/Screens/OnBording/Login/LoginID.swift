//
//  LoginID.swift
//  Godterest
//
//  Created by Varjeet Singh on 17/09/23.
//

import SwiftUI

struct CustomProgressViewStyle: ProgressViewStyle {
    var color: Color
    
    func makeBody(configuration: Configuration) -> some View {
        ProgressView(configuration)
            .foregroundColor(color) // Set the color here
    }
}

struct LoginID: View {
    @ObservedObject var LoginViewModel = LoginVM()
    @Environment(\.isLoggedIn) var isLoggedIn
    
    var body: some View {
        VStack{
            ZStack {
                BackButton()
                Text("Login").fontWeight(.medium).foregroundColor(Color.black).font(.custom("Avenir", size: 20))
            }.padding(.top)
            
            VStack(alignment: .center,spacing: 20 ) {
                Image("Logins").resizable().frame(width: 250, height: 200, alignment: .center)
                VStack(alignment: .leading,spacing: 5 ) {
                    Text("Email").fontWeight(.regular).foregroundColor(Color.black).font(.custom("Avenir", size: 15))
                    HStack {
                        Image(systemName: "envelope").renderingMode(.template).font(.custom("Avenir", size: 16)).foregroundColor(.black.opacity(0.5))
                        TextField("Email address", text: $LoginViewModel.Email).font(.custom("Avenir", size: 16))
                    }.padding().frame(height: 50).background(RoundedRectangle(cornerRadius: 10).foregroundColor(.gray.opacity(0.2))).padding(.bottom)
                    
                    Text("Password").fontWeight(.regular).foregroundColor(Color.black).font(.custom("Avenir", size: 15))
                    HStack {
                        Image(systemName: "lock").resizable().frame(width: 15,height: 18) .foregroundColor(.black.opacity(0.4)).padding(.leading,3)
                        
                        if LoginViewModel.PasswordOpen{
                            TextField( "*******", text: $LoginViewModel.Password).font(.custom("Avenir", size: 16))
                        }else{
                            SecureField( "*******", text: $LoginViewModel.Password).font(.custom("Avenir", size: 16))
                        }
                        Image(systemName:  LoginViewModel.PasswordOpen ? "eye.fill" : "eye.slash.fill" ).font(.custom("Avenir", size: 16)).foregroundColor(.black.opacity(0.4)).onTapGesture {
                            LoginViewModel.PasswordOpen.toggle()
                        }
                    }.padding().frame(height: 50).background(RoundedRectangle(cornerRadius: 10).foregroundColor(.gray.opacity(0.2))).padding(.bottom)
                    Spacer()
                    
                    Button {
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        LoginViewModel.hitSignIN()
                    } label: {
                        HStack{
                            Spacer()
                            if !LoginViewModel.LoginapiLoaded{
                                ProgressView().colorInvert().frame(height: 30)
                            }else{
                                Text("Log In").fontWeight(.medium).foregroundColor(Color.white).font(.custom("Avenir", size: 18))
                            }
                            Spacer()
                        }.frame( height: 60, alignment: .center)
                            .background(RoundedRectangle(cornerRadius: 10)).foregroundStyle(LinearGradient(colors: [Color("App Red"),Color("App Yellow")], startPoint: .leading, endPoint: .trailing)
                            )
                    }.navigationDestination(
                        isPresented: $LoginViewModel.LoginapiCompleted) {
                            TabbarScreen().environment(\.isLoggedIn, true)
                        }
                        .disabled(!LoginViewModel.LoginapiLoaded)
                    
                    
                }.padding(.horizontal ,20)
                
                NavigationLink {
                    AccountSetup()
                } label: {
                    HStack(alignment: .center) {
                        Text("Don't have an account? ").fontWeight(.regular).font(.custom("Avenir", size: 15)).foregroundColor(.gray) +
                        Text("Sign up").font(.custom("Avenir", size: 15)).bold().foregroundColor(.blue)
                    }.padding(.horizontal,40).multilineTextAlignment(.center)
                }
                
                Spacer()
                
            }.padding(20)
        }.navigationBarBackButtonHidden(true)
            .toast(isPresenting: $LoginViewModel.showToast){
                AlertToast(displayMode: AlertToast.DisplayMode.alert, type: .regular, title: LoginViewModel.ErrorType == .LoginAPI ? LoginViewModel.errorMessage : LoginViewModel.ErrorType.errorMessage)
            }
    }
    
    func listAllFonts() {
        let familyNames = UIFont.familyNames
        
        for family in familyNames {
            print("Family: \(family)")
            let fontNames = UIFont.fontNames(forFamilyName: family)
            for fontName in fontNames {
                print("    \(fontName)")
            }
        }
    }
}

struct LoginID_Previews: PreviewProvider {
    static var previews: some View {
        LoginID()
    }
}
