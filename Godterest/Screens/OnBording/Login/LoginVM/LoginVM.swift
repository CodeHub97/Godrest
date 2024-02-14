//
//  LoginVM.swift
//  Godterest
//
//  Created by Varjeet Singh on 17/09/23.
//

import Foundation
import Alamofire

class LoginVM : ObservableObject{

  @Published var Email:String = ""
  @Published var Password:String = ""
  @Published var PasswordOpen:Bool = false 
  @Published var LoginapiCompleted = false
  func hitSignIN(email:String, password:String){
      let url = "http://192.168.1.9:8081/api/user/post-login?email=\(email)&password=\(password)"

      AF.request(url, method: .post).response { response in
          // Handle the response here
          if let data = response.data {
              do {
                  let loginData = try JSONDecoder().decode(LoginDataModel.self, from: data)
                  UserSettings.shared.saveLoginData(loginData)
              } catch {
                  print("Error decoding login data: \(error)")
              }
          }else{
            let json = """
                {"data":{"profession":"Software Engineer","alcohol":"Occasionally","childrenInFuture":null,"education":"Bachelor's Degree","gender":"Male","profilePic":"https://picsum.photos/id/870/200/300?grayscale&blur=2","smoke":"No","ethnicOrigin":null,"otherPic":"https://picsum.photos/200/300?grayscale","descriptions":"A software engineer with a passion for coding.","isEmailVerified":null,"denomination":"Christian","isAccountDeactivated":null,"password":"Password@123","children":"2","dob":"1990-01-15","isAccountDeleted":null,"name":"Tupac 2","id":5,"tall":"6 feet","ethnicGroup":null,"email":"Tupac2@example.com","maritalStatus":null},"status":"success"}
            """

            if let jsonData = json.data(using: .utf8) {
                do {
                    let response = try JSONDecoder().decode(LoginDataModel.self, from: jsonData)
                    print(response)
                  UserSettings.shared.saveLoginData(response)
                  if let savedLoginData = UserSettings.shared.getLoginData() {
                                      print(savedLoginData)
                    self.LoginapiCompleted = true
                                  }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            }
          }
      }
  }


}

// MARK: - LoginData
struct LoginDataModel: Codable {
    let data: LoginDataClass
    let status: String
}

// MARK: - DataClass
struct LoginDataClass: Codable {
    let profession, alcohol: String?
    let childrenInFuture: String?
    let education, gender: String?
    let profilePic: String?
    let smoke: String?
    let ethnicOrigin: String?
    let otherPic: String?
    let descriptions: String?
    let isEmailVerified: String?
    let denomination: String?
    let isAccountDeactivated: String?
    let password, children, dob: String?
    let isAccountDeleted: String?
    let name: String?
    let id: Int?
    let tall: String?
    let ethnicGroup: String?
    let email: String?
    let maritalStatus: String?
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
