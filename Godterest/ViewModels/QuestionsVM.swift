//
//  QuestionsVM.swift
//  Godterest
//
//  Created by Varjeet Singh on 08/09/23.
//

import Foundation
import SwiftUI
import Alamofire

enum Gender : CaseIterable {
    case Male
    case Female
    
    var stringValue: String {
        switch self {
        case .Male:
            return "Male"
        case .Female:
            return "Female"
        }
    }
}

// MARK: - UserProfile
struct UserProfile: Codable {
    let id,email,password, gender, name: String
    let dob, denomination, profession, ethnicgroup: String
    let education, profilepic, otherspic,latitude,longitude, tall: String
    let martialstatus, ethnicorigin, smoke, alcohol: String
    let children, childreninfuture, descriptions: String
}

struct UploadResponse: Decodable {
    let url: String?
    let status: String?
}

class QuestionsVM : ObservableObject{
    
    //  let profile1 = ProfileDatum(childrenInFuture: "Yes", education: "PhD", gender: "Male", creationTime: 1631234567, latitude: 12.34, ethnicOrigin: "Asian", descriptions: "Description 1", isEmailVerified: "Yes", denomination: "Christian", isAccountDeactivated: "No", password: "password1", children: "2", isAccountDeleted: "No", id: 1, tall: "175 cm", email: "user1@example.com", longitude: 56.78, profession: "Engineer", alcohol: "No", profilePic: "https://images.unsplash.com/photo-1537511446984-935f663eb1f4?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80", smoke: "No", updationTime: "1631235678", otherPic: "https://images.unsplash.com/photo-1585483982433-0432b2fefd45?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1974&q=80", dob: "1990-01-01", name: "John Doe", ethnicGroup: "Chinese", maritalStatus: "Single")
    //
    //  let profile2 = ProfileDatum(childrenInFuture: "No", education: "Bachelor's", gender: "Female", creationTime: 1632345678, latitude: 23.45, ethnicOrigin: "African", descriptions: "Description 2", isEmailVerified: "Yes", denomination: "Islam", isAccountDeactivated: "No", password: "password2", children: "0", isAccountDeleted: "No", id: 2, tall: "180 cm", email: "user2@example.com", longitude: 67.89, profession: "Teacher", alcohol: "Yes", profilePic: "https://images.unsplash.com/photo-1585483982433-0432b2fefd45?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1974&q=80", smoke: "No", updationTime: "1632346789", otherPic: "https://images.unsplash.com/photo-1537511446984-935f663eb1f4?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80", dob: "1985-05-15", name: "Jane Smith", ethnicGroup: "Black", maritalStatus: "Married")
    
    
    let hobbies = [
        "Reading",
        "Cooking",
        "Gardening",
        "Photography",
        "Drawing",
        "Painting",
        "Writing",
        "Dancing",
        "Singing",
        "Hiking",
        "Cycling",
        "Running",
        "Swimming",
        "Yoga",
        "Meditation",
        "Traveling",
        "Chess",
        "Video games",
        "Watching movies",
        "Music",
        "Stamps Collect",
        "Coins Collect",
        "Woodworking",
        "Fishing",
        "Sculpting",
        "Pottery",
        "Skydiving",
        "Rock climbing",
        "Surfing",
        "Baking",
        "Skiing",
        "Snowboarding",
        "Knitting",
        "Camping",
        "Magic tricks",
        "Model building",
        "Calligraphy",
        "Bird watching",
        "Volunteering",
        "DIY Projects",
        "Fitness training",
        "Golf",
        "Tennis",
        "Basketball",
        "Football",
        "Table tennis",
        "Badminton",
        "Volleyball",
        "Billiards",
        "Bowling",
        "Shooting "
    ]
    
    
    @Published var allProfiles: [ProfileDatum] = []
    @Published var removedProfileID: Int? = nil
    @Published var isDataLoaded: Bool = false
    @Published var RunSignup: Bool = false
    @Published var Email:String = ""
    @Published var Password:String = ""
    @Published var ConfirmPassword:String = ""
    @Published var Name:String = ""
    @Published var dateofBirth = Date()
    @Published var PasswordOpen:Bool = false
    @Published var ConfirmPasswordOpen:Bool = false
    @Published var GenderSelect:Gender = .Male
    @Published var SelectedProfession = ""
    @Published var isSelectedProfession : String = ""
  @Published var studied = ""
  @Published var studiedAt = ""
    @Published var SelectedProfilePic = ""
    @Published var isSelectedProfilePic : String = ""
    @Published var SelectedProfileUIImage = UIImage()
    @Published var isSelectedProfileUIImage : String = ""
    @Published var SelectedOtherPics = ""
    @Published var isSelectedOtherPics : String = ""
    @Published var SelectedOtherPicsUIImage:[UIImage]?
    @Published var isSelectedOtherPicsUIImage : String = ""
    @Published var SelectedDenomination = ""
    @Published var isSelectedDenomination : String = ""
    @Published var SelectedHeight = ""
    @Published var isSelectedHeight : String = ""
    @Published var SelectedSmokeHabit = ""
    @Published var isSelectedSmokeHabit : String = ""
    @Published var Selectedlatitude = 30.45
    @Published var isSelectedlatitude : String = ""
    @Published var Selectedlongitude = 70.56
    @Published var isSelectedlongitude : String = ""
    @Published var SelectedDrinkHabit = ""
    @Published var isSelectedDrinkHabit : String = ""
    @Published var SelectedHaveChildren = ""
    @Published var isSelectedHaveChildren : String = ""
    @Published var SelectedWantChildren = ""
    @Published var isSelectedWantChildren : String = ""
    @Published var SelectedMaritalStatues = ""
    @Published var isSelectedMaritalStatues : String = ""
    @Published var SelectedEthnic = ""
    @Published var isSelectedEthnic : String = ""
    @Published var SelectedEducation = ""
    @Published var isSelectedEducation : String = ""
    @Published var Bio = ""
    @Published var isBio : String = ""
    @Published var images: [UIImage] = []
    @Published var selectedHobbiesArray: [String] = []
    
    @Published var SelectedHobbies = ""
    @Published var isSelectedHobbies : String = ""
    
    @Published var AddressLineOne = ""
    @Published var City : String = ""
    @Published var State : String = ""
    @Published var Country : String = ""
    @Published var CountryIndex : Int = 1
    @Published var StateIndex : Int = 1
    @Published var PostCode : String = ""
    
    @Published var errorMessage:String = ""
    @Published var SignupapiCompleted = false
    @Published var SignupapiLoaded = true
    @Published var showToast = false
    @Published var ErrorType :ToastErrorTypes = .SignupAPI
    @Published var SelectedChurchCommunity : String = ""
    
    @Published var mobileNumber: String = ""
    @Published var otp: String = ""
    
    var formattedDateOfBirth: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: dateofBirth)
    }
    
    static var Shared = QuestionsVM()
    
    //  var ProfilepicDemoURLS = ["https://images.unsplash.com/photo-1527736947477-2790e28f3443?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1962&q=80","https://images.unsplash.com/photo-1536811145290-bc394643e51e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2127&q=80","https://images.unsplash.com/photo-1520694977332-9122aa8e8b7a?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2127&q=80","https://images.unsplash.com/photo-1527189919029-aeb3d997547d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1970&q=80","https://images.unsplash.com/photo-1527707966195-20ee3acf0509?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1974&q=80","https://images.unsplash.com/photo-1536763225213-b5592b525630?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80","https://images.unsplash.com/photo-1543132685-cd95dd76c03d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2008&q=80","https://plus.unsplash.com/premium_photo-1668197508000-670f472d8dbc?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1974&q=80","https://images.unsplash.com/photo-1524504388940-b1c1722653e1?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1974&q=80","https://images.unsplash.com/photo-1537511446984-935f663eb1f4?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80","https://images.unsplash.com/photo-1624824216985-5639b3071ce6?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1974&q=80","https://images.unsplash.com/photo-1585483982433-0432b2fefd45?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1974&q=80","https://images.unsplash.com/photo-1544005313-94ddf0286df2?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1976&q=80","https://plus.unsplash.com/premium_photo-1667511127370-c9843772312f?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80"]
    
    func validateFields() -> Bool {
        // Check if all fields are filled
        if Email.isEmpty || Password.isEmpty || GenderSelect.stringValue.isEmpty || Name.isEmpty || formattedDateOfBirth.isEmpty || SelectedDenomination.isEmpty || SelectedProfession.isEmpty || studied.isEmpty || studiedAt.isEmpty || SelectedEthnic.isEmpty || SelectedEducation.isEmpty || SelectedHeight.isEmpty || SelectedMaritalStatues.isEmpty || SelectedHobbies.isEmpty || SelectedSmokeHabit.isEmpty || SelectedDrinkHabit.isEmpty || SelectedHaveChildren.isEmpty || SelectedWantChildren.isEmpty || Bio.isEmpty {
            print("All fields must be filled")
            return false
        }
        
        // Check email validation
        if !isValidEmail(email: Email) {
            print("Invalid email address")
            return false
        }
        
        // Add password validation here if needed
        
        return true
    }
    
    func isValidEmail(email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    
    
    func uploadProfileImage(completion: @escaping (String?) -> Void) {
        let image = SelectedProfileUIImage
        guard let imageData = image.jpegData(compressionQuality: 0.5) else {
            completion(nil)
            return
        }
        
        let url = "\(MatchedVM.BaseURL)/aws/upload-file"
        var urlRequest = try! URLRequest(url: url, method: .post)
        urlRequest.timeoutInterval = 60
        
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imageData, withName: "file", fileName: "profile.jpg", mimeType: "image/jpeg")
        }, with: urlRequest)
        .uploadProgress { progress in
            print("Upload Progress: \(progress.fractionCompleted)")
        }
        .responseDecodable(of: UploadResponse.self) { response in
            switch response.result {
            case .success(let uploadResponse):
                print("Uploaded URL: \(uploadResponse.url ?? "")")
                completion(uploadResponse.url)
                
            case .failure(let error):
                print("Error uploading profile image: \(error)")
                completion(nil)
            }
        }
    }
    
    func uploadMultipleFiles(completion: @escaping (String?) -> Void) {
        let selectedImages = images
        let url = "\(MatchedVM.BaseURL)/aws/upload-multiple-files"
        let imageDataArray = selectedImages.compactMap { $0.jpegData(compressionQuality: 0.5) }
        AF.upload(multipartFormData: { multipartFormData in
            for (index, imageData) in imageDataArray.enumerated() {
                multipartFormData.append(imageData, withName: "files", fileName: "file\(index).jpg", mimeType: "image/jpeg")
            }
        }, to: url)
        .responseDecodable(of: UploadResponse.self) { response in
            switch response.result {
            case .success(let uploadResponse):
                let profile = uploadResponse.url?.replacingOccurrences(of: "AKIAUWX5SL2ZDHVG7KO2", with: "")
                print("Uploaded URLs: \(uploadResponse.url ?? "")")
                completion(uploadResponse.url)
                
            case .failure(let error):
                print("Error uploading multiple files: \(error)")
                completion(nil)
            }
        }
    }
    
    
    func clearallfields(){
        self.SelectedDrinkHabit = ""
        self.isSelectedDrinkHabit = ""
        self.SelectedProfession = ""
        self.isSelectedProfession = ""
        self.SelectedWantChildren = ""
        self.isSelectedWantChildren = ""
        self.SelectedEducation = ""
        self.isSelectedEducation = ""
        self.SelectedSmokeHabit = ""
        self.isSelectedSmokeHabit = ""
        self.SelectedHobbies = ""
        self.isSelectedHobbies = ""
        self.Bio = ""
        self.SelectedDenomination = ""
        self.isSelectedDenomination = ""
        self.SelectedHaveChildren = ""
        self.isSelectedHaveChildren = ""
        self.Name = ""
        self.SelectedHeight = ""
        self.isSelectedHeight = ""
        self.SelectedEthnic = ""
        self.isSelectedEthnic = ""
        self.Email = ""
        self.Password = ""
        self.ConfirmPassword = ""
        self.SelectedMaritalStatues = ""
        self.isSelectedMaritalStatues = ""
        self.images = []
        self.SelectedProfilePic = ""
        self.isSelectedProfilePic = ""
        self.isSelectedProfilePic = ""
        self.SelectedProfileUIImage = UIImage()
        self.isSelectedProfileUIImage = ""
        self.SelectedOtherPics = ""
        self.isSelectedOtherPics = ""
        self.isSelectedOtherPics = ""
        self.SelectedOtherPicsUIImage = nil
        self.isSelectedOtherPicsUIImage = ""
    }
    
    func HitCreateAccount() {
        self.SignupapiLoaded = false
        uploadProfileImage { profileImageURL in
            guard let profileImageURL = profileImageURL else {
                // Handle profile image upload failure
                self.ErrorType = .SignupAPI
                self.showToast = true
                self.SignupapiLoaded = true
                return
            }
            let profile = profileImageURL.replacingOccurrences(of: "AKIAUWX5SL2ZDHVG7KO2", with: "")
            self.uploadMultipleFiles { otherPicsURL in
                guard let otherPicsURL = otherPicsURL else {
                    self.ErrorType = .UploadMultiple
                    self.showToast = true
                    self.SignupapiLoaded = true
                    return
                }
                
                let url = "\(MatchedVM.BaseURL)/user/user-profiles"
                let userProfile = UserSignupDataClass(
                    childrenInFuture: self.SelectedWantChildren,
                    education: self.SelectedEducation,
                    gender: self.GenderSelect.stringValue,
                    descriptions: self.Bio,
                    denomination: self.SelectedDenomination,
                    password: self.Password,
                    children: self.SelectedHaveChildren,
                    tall: self.SelectedHeight,
                    email: self.Email,
                    profession: self.SelectedProfession,
                    alcohol: self.SelectedDrinkHabit,
                    address: Address(
                        country: self.Country,
                        emoji: "No Emoji",
                        city: self.City,
                        latitude: 30.45,
                        timeZone: "USA",
                        emojiCode: "EmojiCodeValue",
                        street: self.AddressLineOne,
                        phoneCode: "+1",
                        state: self.State,
                        longitude: 70.85
                    ),
                    profilePic: profile,
                    smoke: self.SelectedSmokeHabit,
                    otherPic: "as",
                    hobbies: self.SelectedHobbies,
                    dob: self.formattedDateOfBirth,
                    name: self.Name,
                    ethnicGroup: self.SelectedEthnic,
                    maritalStatus: self.SelectedMaritalStatues
                )
                
                print(userProfile)
                
                do {
                    let encoder = JSONEncoder()
                    encoder.outputFormatting = .prettyPrinted
                    let jsonData = try encoder.encode(userProfile)
                    if let jsonString = String(data: jsonData, encoding: .utf8) {
                        print("Create Account Json Made :",jsonString)
                    }
                } catch {
                    print("Error encoding user profile: \(error)")
                }
                
                AF.request(url, method: .post, parameters: userProfile, encoder: JSONParameterEncoder.default).response { response in
                    // Handle the response here
                    
                    if let error = response.error {
                        print("Error: \(error.localizedDescription)")
                        self.errorMessage = "Could not Connect to the Server!!!"
                        self.showToast = true
                        self.SignupapiLoaded = true
                        self.ErrorType = .SignupAPI
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
                                        self.SignupapiCompleted = true
                                        self.SignupapiLoaded = true
                                        self.clearallfields()
                                    }
                                } else {
                                    print("Error decoding login data.")
                                    self.SignupapiLoaded = true
                                }
                            } else {
                                // Handle error here, if needed
                                if let reason = json?["reason"] as? String {
                                    self.errorMessage = reason
                                    self.showToast = true
                                    self.SignupapiLoaded = true
                                    self.ErrorType = .SignupAPI
                                    print("Login failed. Reason: \(reason)")
                                } else {
                                    print("Login failed. Unknown reason.")
                                    self.showToast = true
                                    self.SignupapiLoaded = true
                                    self.errorMessage = json?["message"] as? String ?? ""
                                    print(json)
                                    self.ErrorType = .SignupAPI
                                }
                            }
                        } catch {
                            self.SignupapiLoaded = true
                            print("Error decoding data: \(error)")
                        }
                    } else {
                        self.SignupapiLoaded = true
                        print("API Failed hitSignIN")
                    }
                }
            }
        }
    }
    
    
//    func HitEditProfile() {
//        guard let savedLoginData = UserSettings.shared.getLoginData() else {
//            return
//        }
//        print(savedLoginData.data?.id)
//        let url = "\(MatchedVM.BaseURL)/user/user-profiles"
//        
//        let userProfile = UserProfile(
//            id: "\(savedLoginData.data?.id ?? 0)",
//            email: Email,
//            password:Password,
//            gender: GenderSelect.stringValue,
//            name: Name,
//            dob: formattedDateOfBirth,
//            denomination: SelectedDenomination,
//            profession: SelectedProfession,
//            ethnicgroup: SelectedEthnic,
//            education: SelectedEducation,
//            profilepic: "",//ProfilepicDemoURLS.randomElement() ?? ProfilepicDemoURLS[ProfilepicDemoURLS.count - 1],
//            otherspic: "",//"\(ProfilepicDemoURLS[0]),\(ProfilepicDemoURLS[1]),\(ProfilepicDemoURLS[2]),\(ProfilepicDemoURLS[3]),\(ProfilepicDemoURLS[4])"
//            latitude: "30.451",
//            longitude: "70.354",
//            tall: SelectedHeight,
//            martialstatus: SelectedMaritalStatues,
//            ethnicorigin: SelectedHobbies,
//            smoke: SelectedSmokeHabit,
//            alcohol: SelectedDrinkHabit,
//            children: SelectedHaveChildren,
//            childreninfuture: SelectedWantChildren,
//            descriptions: Bio
//        )
//        print("Edit Profile Url ", url)
//        print("Created Params ", userProfile)
//        
//        AF.request(url, method: .post, parameters: userProfile, encoder: JSONParameterEncoder.default).response { response in
//            // Handle the response here
//            if let data = response.data {
//                do {
//                    let savedSignupData = try JSONDecoder().decode(LoginDataModel.self, from: data)
//                    UserSettings.shared.saveLoginData(savedSignupData)
//                    if let savedSignupData = UserSettings.shared.getLoginData() {
//                        print(savedSignupData)
//                    }
//                } catch {
//                    print("Error decoding login data: \(error)")
//                }
//            }else{
//                print("API Failed hitSignIN")
//            }
//        }
//    }
    
    
    
    func HitAllProfileList() {
        guard let savedLoginData = UserSettings.shared.getLoginData() else {
            return
        }
        
        let url = "\(MatchedVM.BaseURL)/user/user-list?id=\(savedLoginData.data?.id ?? 0)"
        print("HitAllProfileList " , url)
        
        AF.request(url, method: .post).responseJSON { response in
            switch response.result {
            case .success(let value):
                var Status = ""
                guard let json = value as? [String: Any]else {
                    return
                }
                Status = json["status"] as! String
                if Status != "fail"{
                    
                    if let json = value as? [String: Any],
                       let AllprofileData = json["data"] as? [[String: Any]] {
                        
                        do {
                            let AllprofileDataList = try JSONDecoder().decode([ProfileDatum].self, from: JSONSerialization.data(withJSONObject: AllprofileData))
                            print(AllprofileDataList)
                            DispatchQueue.main.async {
                                self.allProfiles = AllprofileDataList
                                self.isDataLoaded = true
                            }
                        } catch {
                            print("Error decoding profile data: \(error)")
                        }
                    }
                }else {
                    
                    print("API Error: HitAllProfileList")
                    print(json["message"] as! String)
                }
            case .failure(let error):
                print("API Error: \(error.localizedDescription)")
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
    
    func calculateAge(birthdate: Date) -> Int {
        let calendar = Calendar.current
        let now = Date()
        let ageComponents = calendar.dateComponents([.year], from: birthdate, to: now)
        
        return ageComponents.year ?? 0
    }
    
    @Published var religiousDenominations = [
        "Non-denominational",
        "Protestant",
        "Church of Christ",
        "Baptist",
        "Lutheran",
        "Assemblies of God",
        "Presbyterian",
        "Church of God",
        "Anglican",
        "Nazarene",
        "Methodist",
        "Evangelical",
        "Catholic",
        "Episcopal",
        "Orthodox",
        "Pentecostal",
        "Oriental Orthodox",
        "Latter-day Saints",
        "Jehovah's Witness",
        "United Church of Christ",
        "Undecided"
    ]
    
    @Published var professions = [
        "Accountant",
        "Actor",
        "Air Hostess",
        "Administration Employee",
        "Administration Professional",
        "Architect",
        "Artist",
        "Astronomer",
        "Athlete",
        "Author",
        "Baker",
        "Barista",
        "Bartender",
        "Biologist",
        "Botanist",
        "Carpenter",
        "Chef",
        "Chemist",
        "Coach",
        "Dancer",
        "Dentist",
        "Designer",
        "Detective",
        "Doctor",
        "Economist",
        "Electrician",
        "Engineer",
        "Farmer",
        "Firefighter",
        "Fisherman",
        "Flight Attendant",
        "Freelancer",
        "Geologist",
        "Graphic Designer",
        "Hair Stylist",
        "Historian",
        "Insurance Agent",
        "Interpreter",
        "Journalist",
        "Judge",
        "Lawyer",
        "Librarian",
        "Linguist",
        "Mathematician",
        "Mechanic",
        "Meteorologist",
        "Musician",
        "Nurse",
        "Optometrist",
        "Painter",
        "Paramedic",
        "Pharmacist",
        "Photographer",
        "Physicist",
        "Pilot",
        "Plumber",
        "Police Officer",
        "Professor",
        "Programmer",
        "Psychologist",
        "Real Estate Agent",
        "Receptionist",
        "Singer",
        "Software Engineer",
        "Statistician",
        "Surgeon",
        "Teacher",
        "Translator",
        "Veterinarian",
        "Waiter/Waitress",
        "Writer"
    ]
    
    @Published var ethnicGroups = [
        "White / Caucasian",
        "Hispanic / Latino",
        "American Indian",
        "Black / African Descent",
        "East Asian",
        "Middle Eastern",
        "Pacific Islander",
        "South Asian",
        "Other",
        "Prefer not to say",
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
        "Yes",    "No" , "Sometimes" ,"Prefer not to say"
    ]
    
    @Published var ChildrenHaveArray = [
        "Have kids",    "Don't have kids" , "Prefer not to say"
    ]
    
    @Published var WantChildren = [
        "Want kids", "Open to kids",   "Don't want kids","Prefer not to say"
    ]
    
    @Published var NamesArray = [
        "Aria", "Liam", "Ella", "Noah", "Ava", "Oliver", "Mia", "Isabella",
        "Sophia", "Amelia", "Harper", "Evelyn", "Lucas", "Mason", "Logan",
        "Ethan", "Michael", "Aiden", "Olivia", "Emma", "Charlotte", "Sophia",
        "Amelia", "Aria", "Mia", "Ella", "Avery", "Evelyn", "Harper", "Liam",
        "Noah", "Oliver", "Ethan", "Aiden", "Lucas", "Mason", "Logan", "Michael"
    ]
    
    @Published var ChurchCommunityArray = [
        "Looking for a church",
        "Actively involved weekly",
        "Attend weekly",
        "Attend occasionally",
        "Unable to attend",
        "Not for me"
    ]

    // Function to generate random values
    //  func generateRandomJSON() -> String {
    //
    //      let randomName = NamesArray.randomElement() ?? ""
    //    let randomGender = Gender.allCases.randomElement()?.stringValue
    //      let randomProfession = professions.randomElement() ?? ""
    //      let randomDenomination = religiousDenominations.randomElement() ?? ""
    //      let randomEducationLevel = EducationLevels.randomElement() ?? ""
    //      let randomEthnicGroup = ethnicGroups.randomElement() ?? ""
    //      let randomEthnicOrigin = ethnicOrigins.randomElement() ?? ""
    //      let randomCountryFlagEthnic = CountryFlagsEthnics.randomElement() ?? ""
    //      let randomMaritalStatus = MaritalStatues.randomElement() ?? ""
    //      let randomSmokeHabit = SmokeHabit.randomElement() ?? ""
    //      let randomWantChildren = WantChildren.randomElement() ?? ""
    //
    //      // Construct JSON string
    //      let jsonString = """
    //      {
    //        "email": "\(randomName)@mailinator.com",
    //        "password": "Password@1234",
    //        "gender": "\(randomGender ?? "")",
    //        "name": "\(randomName)",
    //        "dob": "1997-10-13",
    //        "profilePic": "\(ProfilepicDemoURLS.randomElement() ?? "")",
    //        "otherPic": "\(ProfilepicDemoURLS.randomElement() ?? ""),\(ProfilepicDemoURLS.randomElement() ?? ""),\(ProfilepicDemoURLS.randomElement() ?? ""),\(ProfilepicDemoURLS.randomElement() ?? ""),\(ProfilepicDemoURLS.randomElement() ?? "")",
    //        "latitude": "\(Double.random(in: -90...90))",
    //        "longitude": "\(Double.random(in: -180...180))",
    //        "denomination": "\(randomDenomination)",
    //        "profession": "\(randomProfession)",
    //        "education": "\(randomEducationLevel)",
    //        "ethnicGroup": "\(randomEthnicGroup)",
    //        "ethnicOrigin": "\(randomEthnicOrigin)",
    //        "countryflagethnic": "\(randomCountryFlagEthnic)",
    //        "tall": "\(Int.random(in: 150...200)) cm",
    //        "maritalStatus": "\(randomMaritalStatus)",
    //        "smoke": "\(randomSmokeHabit)",
    //        "alcohol": "\(randomSmokeHabit)",
    //        "children": "\(randomSmokeHabit)",
    //        "childrenInFuture": "\(randomWantChildren)",
    //        "descriptions": "A \(randomProfession) with a good Heart."
    //      }
    //      """
    //      return jsonString
    //  }
    
    
    
    let countriesData = """
     {
       "countries": [
         {
           "name": "India",
           "states": ["Andhra Pradesh", "Arunachal Pradesh", "Assam", "Bihar", "Chhattisgarh", "Goa", "Gujarat", "Haryana", "Himachal Pradesh", "Jharkhand", "Karnataka", "Kerala", "Madhya Pradesh", "Maharashtra", "Manipur", "Meghalaya", "Mizoram", "Nagaland", "Odisha", "Punjab", "Rajasthan", "Sikkim", "Tamil Nadu", "Telangana", "Tripura", "Uttar Pradesh", "Uttarakhand", "West Bengal"]
         },
         {
           "name": "USA",
           "states": ["Alabama", "Alaska", "Arizona", "Arkansas", "California", "Colorado", "Connecticut", "Delaware", "Florida", "Georgia", "Hawaii", "Idaho", "Illinois", "Indiana", "Iowa", "Kansas", "Kentucky", "Louisiana", "Maine", "Maryland", "Massachusetts", "Michigan", "Minnesota", "Mississippi", "Missouri", "Montana", "Nebraska", "Nevada", "New Hampshire", "New Jersey", "New Mexico", "New York", "North Carolina", "North Dakota", "Ohio", "Oklahoma", "Oregon", "Pennsylvania", "Rhode Island", "South Carolina", "South Dakota", "Tennessee", "Texas", "Utah", "Vermont", "Virginia", "Washington", "West Virginia", "Wisconsin", "Wyoming"]
         },
         {
           "name": "Canada",
           "states": ["Alberta", "British Columbia", "Manitoba", "New Brunswick", "Newfoundland and Labrador", "Nova Scotia", "Ontario", "Prince Edward Island", "Quebec", "Saskatchewan"]
         },
         {
           "name": "Australia",
           "states": ["New South Wales", "Victoria", "Queensland", "Western Australia", "South Australia", "Tasmania", "Australian Capital Territory", "Northern Territory"]
         }
       ]
     }
     """
    
    func getCountries() -> [CountryData]? {
        guard let data = countriesData.data(using: .utf8) else {
            print("Failed to convert countriesData to Data")
            return nil
        }
        
        do {
            let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            guard let jsonDict = jsonResult as? [String: Any], let countriesArray = jsonDict["countries"] as? [[String: Any]] else {
                print("Error parsing JSON")
                return nil
            }
            
            let countries = countriesArray.compactMap { dict -> CountryData? in
                guard let name = dict["name"] as? String, let states = dict["states"] as? [String] else {
                    return nil
                }
                return CountryData(name: name, states: states)
            }
            CountryAry = countries
            print("countriesArray",countriesArray)
            return countries
        } catch {
            print("Error decoding JSON: \(error)")
            return nil
        }
    }
    
    
    
    var CountryAry:[CountryData] = []
}

struct CountryData: Codable {
    var name: String
    var states: [String]
}

extension QuestionsVM {
    
    //  HOMEPAGE APIS
    func hitLikeRejectApi(ProfilesUserID:Int,isLiked:Int,isReject:Int) {
        guard let savedLoginData = UserSettings.shared.getLoginData() else {
            return
        }
        let url = "\(MatchedVM.BaseURL)/user/profile-interactions?userId=\(savedLoginData.data?.id ?? 0)&interactionsUserId=\(ProfilesUserID)&isLiked=\(isLiked)&isRejected=\(isReject)"
        print("hitLikeRejectApi " , url)
        
        AF.request(url, method: .post).responseJSON { response in
            switch response.result {
            case .success(let value):
                var Status = ""
                guard let json = value as? [String: Any]else {
                    return
                }
                Status = json["status"] as! String
                if Status != "fail"{
                    
                    if let json = value as? [String: Any]{
                        let message = json["status"] as? String ?? ""
                        print(ProfilesUserID)
                        withAnimation {
                            self.removeProfile(withID: ProfilesUserID)
                        }
                        print(message)
                    }
                }
            case .failure(let error):
                print("API Error: \(error.localizedDescription)")
            }
        }
    }
}
