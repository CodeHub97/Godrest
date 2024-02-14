//
//  QuestionsVM.swift
//  Godterest
//
//  Created by Varjeet Singh on 08/09/23.
//

import Foundation
import SwiftUI
import Alamofire

enum Gender {
case Male
case Female
}


// MARK: - UserProfile
struct UserProfile: Codable {
    let email,password, gender, name: String
    let dob, denomination, profession, ethnicgroup: String
    let education, profilepic, otherspic, tall: String
    let martialstatus, ethnicorigin, smoke, alcohol: String
    let children, childreninfuture, descriptions: String
}

// MARK: - AllProfileList
struct AllProfileList: Codable {
    let data: [ProfileData]
    let status: String
}

// MARK: - ProfileData
struct ProfileData: Codable {
    let profession, alcohol: String?
    let childrenInFuture: String?
    let education, gender: String?
    let profilePic: String?
    let smoke: String?
    let ethnicOrigin, otherPic: String?
    let descriptions: String?
    let isEmailVerified: Bool?
    let denomination: String?
    let isAccountDeactivated: Bool?
    let password: String?
    let children, dob: String?
    let isAccountDeleted: Bool?
    let name: String?
    let id: Int?
    let tall: String?
    let ethnicGroup: String?
    let email: String?
    let maritalStatus: String?
}


class QuestionsVM : ObservableObject{

  @Published var allProfiles: [ProfileData] = []
  @Published var removedProfileID: Int? = nil
  @Published var isDataLoaded: Bool = false
  func HitCreateAccount() {
          let url = "http://192.168.1.9:8081/api/user/user-profiles"

    let userProfile = UserProfile(
        email: "Tupac2@example.com",
        password:"Password@123",
        gender: "Male",
        name: "Tupac 2",
        dob: "1990-01-15",
        denomination: "Christian",
        profession: "Software Engineer",
        ethnicgroup: "Caucasian",
        education: "Bachelor's Degree",
        profilepic: "profile.jpg",
        otherspic: "other.jpg",
        tall: "6 feet",
        martialstatus: "Married",
        ethnicorigin: "English",
        smoke: "No",
        alcohol: "Occasionally",
        children: "2",
        childreninfuture: "Yes",
        descriptions: "A software engineer with a passion for coding."
    )



          AF.request(url, method: .post, parameters: userProfile, encoder: JSONParameterEncoder.default).response { response in
              // Handle the response here
              if let data = response.data {
                  if let stringData = String(data: data, encoding: .utf8) {
                      print(stringData)
                  }
              }
          }
      }

  func HitAllProfileList(UserId : Int) {
      let url = "http://192.168.1.9:8081/api/user/user-list?id=\(UserId)"

    AF.request(url, method: .post).response { response in
        // Handle the response here
        if let data = response.data {
            do {
                let loginData = try JSONDecoder().decode(AllProfileList.self, from: data)
                print(loginData)
              self.isDataLoaded = true
            } catch {
                print("Error decoding login data: \(error)")
            }
        }else{
          let json = """
              {"data":[{"profession":"Software Engineer","alcohol":"Occasionally","childrenInFuture":null,"education":"Bachelor's Degree","gender":"Male","profilePic":"https://images.unsplash.com/photo-1534528741775-53994a69daeb?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1964&q=80","smoke":"No","ethnicOrigin":null,"otherPic":"https://picsum.photos/id/870/200/300?grayscale&blur=2","descriptions":"A software engineer with a passion for coding.","isEmailVerified":null,"denomination":"Christian","isAccountDeactivated":null,"password":null,"children":"2","dob":"1990-01-15","isAccountDeleted":null,"name":"Lara","id":1,"tall":"6 feet","ethnicGroup":null,"email":"sanjit@example.com","maritalStatus":null},{"profession":"Software Engineer","alcohol":"Occasionally","childrenInFuture":null,"education":"Bachelor's Degree","gender":"Male","profilePic":"https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1974&q=80","smoke":"No","ethnicOrigin":null,"otherPic":null,"descriptions":"A software engineer with a passion for coding.","isEmailVerified":false,"denomination":"Christian","isAccountDeactivated":false,"password":null,"children":"2","dob":"1990-01-15","isAccountDeleted":false,"name":"Fendi","id":2,"tall":"6 feet","ethnicGroup":null,"email":"Varjeet@example.com","maritalStatus":null},{"profession":"Software Engineer","alcohol":"Occasionally","childrenInFuture":null,"education":"Bachelor's Degree","gender":"Male","profilePic":"https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1974&q=80","smoke":"No","ethnicOrigin":null,"otherPic":"https://picsum.photos/seed/picsum/200/300,https://picsum.photos/id/870/200/300?grayscale&blur=2,https://picsum.photos/200/300","descriptions":"A software engineer with a passion for coding.","isEmailVerified":null,"denomination":"Christian","isAccountDeactivated":null,"password":null,"children":"2","dob":"1990-01-15","isAccountDeleted":null,"name":"Roman","id":3,"tall":"6 feet","ethnicGroup":null,"email":"Tupac@example.com","maritalStatus":null},{"profession":"Software Engineer","alcohol":"Occasionally","childrenInFuture":null,"education":"Bachelor's Degree","gender":"Male","profilePic":"https://images.unsplash.com/photo-1517841905240-472988babdf9?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1974&q=80","smoke":"No","ethnicOrigin":null,"otherPic":"https://picsum.photos/200/300?grayscale","descriptions":"A software engineer with a passion for coding.","isEmailVerified":null,"denomination":"Christian","isAccountDeactivated":null,"password":"Password@123","children":"2","dob":"1990-01-15","isAccountDeleted":null,"name":"Letty","id":4,"tall":"6 feet","ethnicGroup":null,"email":"Tupac2@example.com","maritalStatus":null}],"status":"success"}
          """

          if let jsonData = json.data(using: .utf8) {
              do {
                  let response = try JSONDecoder().decode(AllProfileList.self, from: jsonData)
                  print(response)
                  self.allProfiles = response.data
                self.isDataLoaded = true
              } catch {
                  print("Error decoding JSON: \(error)")
              }
          }
        }
    }
}


  func removeProfile(withID id: Int?) {
          if let id = id, let index = allProfiles.firstIndex(where: { $0.id == id }) {
              allProfiles.remove(at: index)
          }
      }

   func isProfileRemoved(withID id: Int) -> Bool {
          return removedProfileID == id
      }





  @Published var Email:String = ""
  @Published var Password:String = ""
  @Published var PasswordOpen:Bool = false
  @Published var GenderSelect:Gender = .Male

  func calculateAge(birthdate: Date) -> Int {
          let calendar = Calendar.current
          let now = Date()
          let ageComponents = calendar.dateComponents([.year], from: birthdate, to: now)

          return ageComponents.year ?? 0
      }

 @Published var religiousDenominations = [
      "Non-denominational",
      "Church of Christ",
      "Baptist",
      "Lutheran",
      "Presbyterian",
      "Methodist",
      "Catholic",
      "Episcopal",
      "Pentecostal",
      "Seventh-day Adventist",
      "Jehovah's Witnesses",
      "Eastern Orthodox",
      "Quaker",
      "Unitarian Universalist",
      "Mormon (Latter-day Saint)",
      "Salvation Army",
      "Assemblies of God",
      "Amish",
      "Christian Science",
      "Disciples of Christ"
  ]

  @Published var professions = [
      "Accountant","Acting professional ","Freelancer","Air Hostess","Administration Employee","Administration Professional ",
      "Engineer",
      "Teacher",
      "Lawyer",
      "Nurse",
      "Software Developer",
      "Architect",
      "Police Officer",
      "Chef",
      "Artist",
      "Pilot",
      "Accountant",
      "Dentist",
      "Psychologist",
      "Graphic Designer",
      "Electrician",
      "Plumber",
      "Mechanic",
      "Journalist",
      "Photographer",
      "Firefighter",
      "Social Worker",
      "Scientist",
      "Athlete",
      "Entrepreneur"
  ]

  @Published var ethnicGroups = [
      "America's",
      "Europe",
      "Sub-Saharan Africa",
      "African",
      "Asia Pacific",
      "Middle East-North Africa",
      "Unknown",
      "Russian",
      "Japanese",
      "Malay",
      "Arab",
      "Javanese",
      "Lahnda",
      "Tamil",
      "Turkic",
      "Vietnamese",
      "Korean",
      "Telugu",
      "Marathi",
      "French",
      "Urdu",
      "Wu",
      "Punjabi",
      "Gujarati",
      "Bhojpuri"
  ]
  @Published var EducationLevels = [
      "High school",
      "Non- degree qualification",
      "Undergraduate degree",
      "Postgraduate degree",
      "Doctorate",
      "Other",
  ]


  @Published var ethnicOrigins = [
      "English",  "Japanese", "Italian" ,"German", "Indian", "Chinese", "Argentina", "Austrian", "Brazilian", "Canadian", "England", "Korean",
  ]

  @Published var CountryFlagsEthnics = [
    "America",    "Japan",    "Italian",    "German",    "India", "China", "Argentina", "Austria", "Brazil", "Canada", "England", "Korea",

    ]
  @Published var MaritalStatues = [
    "Never married",    "Divorced",    "Separated",    "Annulled",
        "Widowed"
    ]

  @Published var SmokeHabit = [
    "Yes",    "No"
    ]

  @Published var WantChildren = [
    "Yes", "Maybe",   "No","Prefer not to say"
    ]




  @Published var SelectedProfession = ""
  @Published var SelectedSmokeHabit = ""
  @Published var SelectedDrinkHabit = ""
  @Published var SelectedHaveChildren = ""
  @Published var SelectedWantChildren = ""
  @Published var SelectedMaritalStatues = ""
  @Published var SelectedEthnic = ""
  @Published var SelectedEthnicOrigins = ""
  @Published var SelectedEducation = ""
  @Published var Bio = ""

 

}
