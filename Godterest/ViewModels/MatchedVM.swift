//
//  MatchedVM.swift
//  Godterest
//
//  Created by Varjeet Singh on 21/09/23.
//

import Foundation
import Alamofire

class MatchedVM : ObservableObject{
    
    static let BaseURL = "http://3.230.250.53:8081/api" 
//    static let S3BaseURL = "http://3.230.250.53:8081/api"
    @Published var allMatchedProfiles: [ProfileDatum] = []
    @Published var isDataLoaded = false
    @Published var DeleteapiLoaded = true
    @Published var showToast = false
    @Published var ErrorType :ToastErrorTypes = .DeleteAccountAPI
    
    @Published var images: [String] = ["https://images.unsplash.com/photo-1527736947477-2790e28f3443?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1962&q=80","https://images.unsplash.com/photo-1536811145290-bc394643e51e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2127&q=80","https://images.unsplash.com/photo-1520694977332-9122aa8e8b7a?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2127&q=80"]
    
    func HitAllMatchedList(type:String) {
        guard let savedLoginData = UserSettings.shared.getLoginData() else {
            return
        }
        
        let url = "\(MatchedVM.BaseURL)/user/profile-liked-rejected?userId=\(savedLoginData.data?.id ?? 6)&status=Liked&type=\(type)"
        
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
                       let AllMatchedprofileData = json["data"] as? [[String: Any]] {
                        
                        do {
                            let AllMatchedprofileDataList = try JSONDecoder().decode([ProfileDatum].self, from: JSONSerialization.data(withJSONObject: AllMatchedprofileData))
                            //                print(AllMatchedprofileDataList)
                            DispatchQueue.main.async {
                                self.allMatchedProfiles = AllMatchedprofileDataList
                                self.isDataLoaded = true
                            }
                        } catch {
                            print("Error decoding profile data: \(error)")
                        }
                    }
                }else {
                    
                    print(json["message"] as! String)
                }
            case .failure(let error):
                print("API Error: \(error.localizedDescription)")
            }
        }
    }
    
    func HitDeleteorDeactivateAccount(type:String) {
        
        guard let savedLoginData = UserSettings.shared.getLoginData() else {
            return
        }
        let typeer = type == "Delete" ? true : false
        print(typeer)
        
        DeleteapiLoaded = false
        let url = "\(MatchedVM.BaseURL)/user/deactivate-or-delete?id=\(savedLoginData.data?.id ?? 1)&isAccountDeactivated=\(!typeer)&isAccountDeleted=\(typeer)"
        print(url)
        
        AF.request(url, method: .post).responseJSON { response in
            switch response.result {
            case .success(let value):
                var Status = ""
                self.DeleteapiLoaded = true
                guard let json = value as? [String: Any]else {
                    
                    return
                }
                Status = json["status"] as! String
                if Status != "fail"{
                    
                    if let message = json["message"] as? String{
                        self.showToast = true
                        
                        self.ErrorType = .DeleteAccountAPI
                        print(message)
                    }
                }else {
                    
                    print(json["status"] as! String)
                }
            case .failure(let error):
                self.DeleteapiLoaded = true
                self.showToast = true
                self.ErrorType = .FailedAPI
                print("API Error: \(error.localizedDescription)")
            }
        }
    }
    
    func reportUser(otherUserId: Int, reason: String, completion: @escaping(Bool)-> Void) {
        guard let savedLoginData = UserSettings.shared.getLoginData() else {
            return
        }
        let userId = savedLoginData.data?.id ?? 0
        let url = "\(APIConstants.EndPoints.reportUser)?\(APIKeys.userId)=\(userId)&\(APIKeys.otherUserId)=\(otherUserId)&\( APIKeys.message)=Report"
        ApiManager<LoginDataModel>.makeApiCall(url: url,
                                               params: [:],
                                               headers: nil,
                                               method: .post) { _, responseModel in
            
            if let statusCode = responseModel?.status, let model = responseModel {
                completion(statusCode == "success")
            }
        }
    }
    
    func blockUser(otherUserId: Int, reason: String, completion: @escaping(Bool)-> Void) {
        guard let savedLoginData = UserSettings.shared.getLoginData() else {
            return
        }
        let userId = savedLoginData.data?.id ?? 0
        
        let url = "\(APIConstants.EndPoints.blockUser)?\(APIKeys.userId)=\(userId)&\(APIKeys.otherUserId)=\(otherUserId)&\( APIKeys.message)=Block"
        ApiManager<LoginDataModel>.makeApiCall(url: url,
                                               headers: nil,
                                               method: .post) { _, responseModel in
            
            if let statusCode = responseModel?.status, let model = responseModel {
                completion(statusCode == "success")
            }
        }
    }
}
