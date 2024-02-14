//
//  EditProfileViewModel.swift
//  Godterest
//
//  Created by Varjeet Singh on 20/09/23.
//

import Foundation
import UIKit
import Alamofire

class EditProfileViewModel : ObservableObject{
    
    @Published var allProfiles: [ProfileDatum] = []
    @Published var removedProfileID: Int? = 0
    @Published var isDataLoaded: Bool = false
    @Published var Email:String = ""
    @Published var Name:String = ""
    @Published var dateofBirth = ""
    @Published var ProfilePic = ""
    @Published var OtherPics = ""
    @Published var Password:String = ""
    @Published var GenderSelect = ""
    @Published var SelectedProfession = ""
    @Published var SelectedDenomination = ""
    @Published var SelectedHeight = ""
    @Published var SelectedSmokeHabit = ""
    @Published var SelectedDrinkHabit = ""
    @Published var SelectedHaveChildren = ""
    @Published var SelectedWantChildren = ""
    @Published var SelectedMaritalStatues = ""
    @Published var SelectedEthnic = ""
    @Published var SelectedHobbies = ""
    @Published var SelectedEducation = ""
    @Published var Bio = ""
    @Published var Location = ""
    @Published var MYProfile: UserProfile?
    @Published var images: [String] = []
    @Published var SelectedProfileUIImage = UIImage()
    
    static var Shared = EditProfileViewModel()
    
    func calculateDisplayValue(value: Int, selectedUnit: String) -> String {
        switch selectedUnit {
        case "cm":
            return "\(value) cm"
        case "Ft":
            let feet = Double(value) * 0.0328084 // 1 cm ≈ 0.0328084 ft
            return String(format: "%.1f ft", feet)
        default:
            return "\(value)"
        }
    }
    
    func convertDateFormat(dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = "yyyy-MM-dd"     //"MM/dd/yyyy"
            return dateFormatter.string(from: date)
        }
        return "Invalid Date"
    }
     
    func setProfileData() {
        guard let savedProfileData = UserSettings.shared.getLoginData()?.data else {
            return
        }
        
        self.Email = savedProfileData.email ?? ""
        self.Name = savedProfileData.name ?? ""
        self.dateofBirth = convertDateFormat(dateString: savedProfileData.dob ?? Date().description)
        self.Password = ""
        self.GenderSelect = savedProfileData.gender ?? ""
        self.SelectedProfession = savedProfileData.profession  ?? ""
        self.SelectedDenomination = savedProfileData.denomination  ?? ""
       // let height = savedProfileData.tall ?? ""
//        if let heightnumericValue = Int(height.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()) {
//            print(heightnumericValue) // This will print: 125
//            self.SelectedHeight = calculateDisplayValue(value: heightnumericValue, selectedUnit: "Ft")
//        } else {
//            self.SelectedHeight = savedProfileData.tall ?? ""
//        }
        self.SelectedHeight = savedProfileData.tall ?? ""
        self.ProfilePic = savedProfileData.profilePic ?? ""
        self.OtherPics = savedProfileData.otherPic ?? ""
        images = OtherPics.components(separatedBy: ",")
        
        self.SelectedSmokeHabit = savedProfileData.smoke  ?? ""
        self.SelectedDrinkHabit = savedProfileData.alcohol  ?? ""
        self.SelectedHaveChildren = savedProfileData.children  ?? ""
        self.SelectedWantChildren = savedProfileData.childrenInFuture  ?? ""
        self.SelectedMaritalStatues = savedProfileData.maritalStatus  ?? ""
        self.SelectedEthnic = savedProfileData.ethnicGroup  ?? ""
        self.SelectedHobbies = savedProfileData.hobbies  ?? ""
        self.SelectedEducation = savedProfileData.education  ?? ""
        self.Bio = savedProfileData.descriptions ?? ""
        self.Location = "10002"//"\(savedProfileData.address?.city ?? "Pine Lane"), \(savedProfileData.address?.state ?? "Riverside"),\(savedProfileData.address?.country ?? "USA")"
        
        // Mark data as loaded
        self.isDataLoaded = true
    }
    
    func validateFeilds() -> Bool {
        if (self.Email.isEmpty ||
            self.Name.isEmpty ||
            self.dateofBirth.isEmpty ||
            self.GenderSelect.isEmpty ||
            self.SelectedProfession.isEmpty ||
            self.SelectedDenomination.isEmpty ||
            self.SelectedHeight.isEmpty ||
            self.ProfilePic.isEmpty ||
            self.SelectedSmokeHabit.isEmpty ||
            self.SelectedDrinkHabit.isEmpty ||
            self.SelectedHaveChildren.isEmpty ||
            self.SelectedWantChildren.isEmpty ||
            self.SelectedMaritalStatues.isEmpty ||
            self.SelectedEthnic.isEmpty ||
            //        self.SelectedHobbies.isEmpty ||
            self.SelectedEducation.isEmpty ||
            self.Bio.isEmpty ||
            self.Location.isEmpty) {
            return false
        }
        
        return true
    }
    
    func callEditProfileAPI(completion: @escaping(Bool)-> Void) {
        
        guard let savedLoginData = UserSettings.shared.getLoginData() else {
            return
        }
        // let url = "\(MatchedVM.BaseURL)/user/user-profiles"
        var tall = SelectedHeight
//        if let decimal = Decimal(string: tall.trimmingCharacters(in: CharacterSet.letters.union(.whitespaces))) {
//            print(decimal)
//            // convert to cm
//            var value = decimal * 30.48
//            value = Decimal(floor(NSDecimalNumber(decimal: value).doubleValue))
//            tall = "\((NSDecimalNumber(decimal: value).intValue)) cm"
//        }
        
        let params = [
            "id": "\(savedLoginData.data?.id ?? 0)",
            "email": Email,
            "password":Password,
            "gender": GenderSelect,
            "name": Name,
            "dob": dateofBirth,
            "denomination": SelectedDenomination,
            "profession": SelectedProfession,
            "ethnicGroup": SelectedEthnic,
            "education": SelectedEducation,
            "profilePic": ProfilePic,//ProfilepicDemoURLS.randomElement() ?? ProfilepicDemoURLS[ProfilepicDemoURLS.count - 1],
            "otherPic":images.joined(separator:","), //OtherPics,//"\(ProfilepicDemoURLS[0]),\(ProfilepicDemoURLS[1]),\(ProfilepicDemoURLS[2]),\(ProfilepicDemoURLS[3]),\(ProfilepicDemoURLS[4])"
            "latitude": "30.451",
            "longitude": "70.354",
            "tall": tall,
            "maritalStatus": SelectedMaritalStatues,
            "ethnicOrigin": SelectedHobbies,
            "smoke": SelectedSmokeHabit,
            "alcohol": SelectedDrinkHabit,
            "children": SelectedHaveChildren,
            "childrenInFuture": SelectedWantChildren,
            "descriptions": Bio]
        ApiManager<LoginDataModel>.makeApiCall(url: APIConstants.EndPoints.profile,
                                               params: params,
                                               headers: nil,
                                               method: .post) { _, responseModel in
            
            if let statusCode = responseModel?.status, let model = responseModel {
                if statusCode == "success" {
                    UserSettings.shared.saveLoginData(model)
                }
                
                completion(statusCode == "success")
            }
        }
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
    
    func uploadMultipleFiles(images:[UIImage],completion: @escaping (String?) -> Void) {
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
}
