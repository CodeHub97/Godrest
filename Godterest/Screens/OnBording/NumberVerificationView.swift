//
//  NumberVerificationView.swift
//  Godterest
//
//  Created by Gaganpreet Singh on 1/17/24.
//

import SwiftUI
import Combine

struct CPData: Codable, Identifiable {
    let id: String
    let name: String
    let flag: String
    let code: String
    let dial_code: String
    let pattern: String
    let limit: Int
    
    static let allCountry: [CPData] = Bundle.main.decode("CountryNumbers.json")
    static let example = allCountry[0]
}

extension Bundle {
    func decode<T: Decodable>(_ file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }

        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }

        let decoder = JSONDecoder()

        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode \(file) from bundle.")
        }

        return loaded
    }
}



struct NumberVerificationView: View {
    @EnvironmentObject var CreateAccountVM : QuestionsVM
  @State private var text: String = ""
    @FocusState private var isFocused: Bool
  @State private var moveToNext = false
  
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
                        Text("What’s your number?")
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
                          
                          TextField("", text: $CreateAccountVM.mobileNumber)
                              .placeholder(when: CreateAccountVM.mobileNumber.isEmpty) {
                                  Text("Phone number")
                                      .foregroundColor(.secondary)
                              }
                              .focused($keyIsFocused)
                              .keyboardType(.numbersAndPunctuation)
                              .onReceive(Just($CreateAccountVM.mobileNumber)) { _ in
                                  applyPatternOnNumbers(&mobPhoneNumber, pattern: countryPattern, replacementCharacter: "#")
                              }
                              .padding(0)
                              .frame(minWidth: 80, minHeight: 60)
                              .background(Color.white, in: RoundedRectangle(cornerRadius: 10, style: .continuous))
                              .foregroundColor(.black)
                          
                          
//                          iPhoneNumberField( text: $CreateAccountVM.mobileNumber, formatted: true)
//                            .clearButtonMode(.whileEditing)
//                            .flagHidden(false)
//                            .flagSelectable(true)
//                            .prefixHidden(false)
//                            .focused($isFocused)
//                            .onChange(of: CreateAccountVM.mobileNumber) { oldValue, newValue in
//                                print("Changing from \(oldValue) to \(newValue)")
//                            }
//                            .font(.custom("Avenir", size: 16))
//                            .frame(height: 60)
//                            .keyboardType(.numberPad)
//                          
////                          TextField("Enter number", text: $CreateAccountVM.mobileNumber.max(10))
////                            .onChange(of: CreateAccountVM.mobileNumber) { oldValue, newValue in
////                                print("Changing from \(oldValue) to \(newValue)")
////                            }
////                            .font(.custom("Avenir", size: 16))
////                            .frame(height: 60)
////                            .keyboardType(.numberPad)
                        }.background(Color.white)
                        .cornerRadius(10)
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
                                      CreateAccountVM.countryCode = country.dial_code
                                    }
                                }
                                .listStyle(.plain)
                                .searchable(text: $searchCountry, prompt: "Your country")
                            }
                            .presentationDetents([.medium, .large])
                        }
                        .presentationDetents([.medium, .large])
                      
                      HStack {
                        
                        TextField("", text: $CreateAccountVM.Password)
                              .placeholder(when: CreateAccountVM.Password.isEmpty) {
                                  Text("Password")
                                      .foregroundColor(.secondary)
                              }
                          .onChange(of: CreateAccountVM.Password) { oldValue, newValue in
                              print("Changing from \(oldValue) to \(newValue)")
                          }
                          .font(.custom("Avenir", size: 16))
                              .keyboardType(.default)
                              .foregroundColor(.black)
                      }.padding().frame(height: 60).background(RoundedRectangle(cornerRadius: 10)
                          .foregroundColor(.white))
                      
                        
                        .padding(0).frame(height: 60).background(RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(.white))
                        //Spacer()
                    }.padding(.horizontal ,20)
                }.padding(0)
            }
            Text("We never share this with anyone. It won't be on your profile.")
                .frame(width: 250)
                .multilineTextAlignment(.center)
                .foregroundColor(.gray)
                .padding(-10)
          
          //CustomButton2(ButtonType:, action: <#T##() -> Void#>)
          
          CustomButton3(ButtonTitle: "Verify", ButtonType: .mobileNumber) {
              UIApplication.shared.endEditing()
                  
           
              CreateAccountVM.HitGenerateOtp { id in
                  moveToNext = true
                  self.userId = id
              }
            
          }.cornerRadius(30).padding(.all)
          Spacer()
          
//            CustomButton(ButtonTitle: "Verify", ButtonType: .mobileNumber ,View: AnyView(VerifyView()), fontSize: 22).cornerRadius(30).padding(.all)
//
            
        }.navigationBarBackButtonHidden()
            .navigationDestination(isPresented: $moveToNext , destination: {
                VerifyView(userId: userId)
            })
        .background( Color(Color("App Background")))
        .onAppear {
            isFocused = true
            CreateAccountVM.countryCode = countryCode
        }
        
        .toast(isPresenting: $CreateAccountVM.showToast){
          AlertToast(displayMode: AlertToast.DisplayMode.alert, type: .regular, title:  CreateAccountVM.errorMessage)
               
        }
        .overlay{
          if !CreateAccountVM.generateOtpApi{
            ProgressView("Creating account Please wait...").padding(.horizontal , 80).padding(.vertical , 30).background(RoundedRectangle(cornerRadius: 20).fill(Material.ultraThinMaterial).opacity(0.7))
          }
        }
    }
}

#Preview {
    NumberVerificationView().environmentObject(QuestionsVM())
    
   // VerifyView(userId: 23).environmentObject(QuestionsVM())
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

extension NumberVerificationView {
  
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
extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {
            
            ZStack(alignment: alignment) {
                placeholder().opacity(shouldShow ? 1 : 0)
                self
            }
        }
}
extension View {
    func hideKeyboard() {
        let resign = #selector(UIResponder.resignFirstResponder)
        UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
    }
}
extension View {
    func disableWithOpacity(_ condition: Bool) -> some View {
        self
            .disabled(condition)
            .opacity(condition ? 0.6 : 1)
    }
}
struct OnboardingButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: 10, style: .continuous )
                .frame(height: 49)
                .foregroundColor(Color(.systemBlue))
            
            configuration.label
                .fontWeight(.semibold)
                .foregroundColor(Color(.white))
        }
    }
}

struct VerifyView: View {
    @EnvironmentObject var CreateAccountVM : QuestionsVM
    @State var userId: Int
    
    init(userId: Int) {
        self.userId = userId
    }
    var body: some View {
        VStack{
         //   BackButton().padding(.top)
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
                CreateAccountVM.VerifyUser(userId: userId) {
                   
                }
            }.cornerRadius(30).padding(.all)
            Spacer()
            
        }.background( Color(Color("App Background")))
            .navigationBarBackButtonHidden()
            .navigationDestination(isPresented: $CreateAccountVM.otpVerified , destination: {
                NameView().navigationBarBackButtonHidden()
            })
        
            .toast(isPresenting: $CreateAccountVM.showToast){
              AlertToast(displayMode: AlertToast.DisplayMode.alert, type: .regular, title:  CreateAccountVM.errorMessage)
                   
            }
            .overlay{
              if CreateAccountVM.otpVerificationStart{
                ProgressView("Verifing...").padding(.horizontal , 80).padding(.vertical , 30).background(RoundedRectangle(cornerRadius: 20).fill(Material.ultraThinMaterial).opacity(0.7))
              }
            }
            
    }
}


