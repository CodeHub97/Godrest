//
//  LoginVM.swift
//  Godterest
//
//  Created by Varjeet Singh on 17/09/23.
//

import Foundation
import Alamofire


enum ToastErrorTypes: CaseIterable {
    case Validations
    case LoginAPI
    case DeleteAccountAPI
    case DeactivateAccountAPI
    case FailedAPI
    case SignupAPI
    case UploadProfile
    case UploadMultiple

    var errorMessage: String {
        switch self {
        case .Validations:
            return "Please fill all the fields"
        case .LoginAPI:
          return "Login Unsuccessfull"
        case .DeleteAccountAPI:
          return "Account Deletion processed"
        case .DeactivateAccountAPI:
          return "Account Deactivation processed"
        case .FailedAPI:
          return "Something went wrong try again later"
        case .SignupAPI:
          return "Create account Failed!!!,Please try again later..."
        case .UploadProfile:
          return "Signup Unsuccessfull"
        case .UploadMultiple:
          return "Signup Unsuccessfull"
        }
    }
}


class LoginVM : ObservableObject{

  @Published var Email:String = "" //john@yopmail.com"
  @Published var Password:String = "" //Test@123"
  @Published var errorMessage:String = ""
  @Published var PasswordOpen:Bool = false 
  @Published var LoginapiCompleted = false
  @Published var LoginapiLoaded = true
  @Published var showToast = false
  @Published var ErrorType :ToastErrorTypes = .Validations

  func hitSignIN() {

      if Email.isEmpty || Password.isEmpty {
          showToast = true
          ErrorType = .Validations
          return
      }

      let url = "\(MatchedVM.BaseURL)/user/post-login"
      let parameters: [String: String] = ["email": Email, "password": Password]
    self.LoginapiLoaded = false
      AF.request(url, method: .post, parameters: parameters).response { response in
          // Handle the response here

          if let error = response.error {
              print("Error: \(error.localizedDescription)")
            self.errorMessage = "Could not Connect to the Server!!!"
            self.showToast = true
            self.LoginapiLoaded = true
            self.ErrorType = .LoginAPI
              return
          }

          if let data = response.data {
              do {
                  let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]

                  if let status = json?["status"] as? String, status == "success" {
                      if let loginData = try? JSONDecoder().decode(LoginDataModel.self, from: data) {
                          UserSettings.shared.saveLoginData(loginData)

                          if let savedLoginData = UserSettings.shared.getLoginData() {
                              print(savedLoginData)
                              self.LoginapiCompleted = true
                            self.LoginapiLoaded = true
                          }
                      } else {
                          print("Error decoding login data.")
                        self.LoginapiLoaded = true
                      }
                  } else {
                      // Handle error here, if needed
                      if let reason = json?["reason"] as? String {
                        self.errorMessage = reason
                        self.showToast = true
                        self.LoginapiLoaded = true
                        self.ErrorType = .LoginAPI
                          print("Login failed. Reason: \(reason)")
                      } else {
                          print("Login failed. Unknown reason.")
                        self.showToast = true
                        self.LoginapiLoaded = true
                        self.errorMessage = json?["message"] as? String ?? ""
                        self.ErrorType = .LoginAPI
                      }
                  }
              } catch {
                self.LoginapiLoaded = true
                  print("Error decoding data: \(error)")
              }
          } else {
            self.LoginapiLoaded = true
              print("API Failed hitSignIN")
          }
      }
  }

}


class UserSettings {
    static let shared = UserSettings()
    private let userDefaults = UserDefaults.standard

    func saveLoginData(_ loginData: LoginDataModel) {
        do {
            let encodedData = try JSONEncoder().encode(loginData)
            userDefaults.set(encodedData, forKey: "loginData")
        } catch {
            print("Error encoding login data: \(error)")
        }
    }

    func getLoginData() -> LoginDataModel? {
        if let savedData = userDefaults.data(forKey: "loginData") {
            do {
                let loginData = try JSONDecoder().decode(LoginDataModel.self, from: savedData)
                return loginData
            } catch {
                print("Error decoding login data: \(error)")
                return nil
            }
        }
        return nil
    }

    func clearLoginData() {
        userDefaults.removeObject(forKey: "loginData")
    }
}
