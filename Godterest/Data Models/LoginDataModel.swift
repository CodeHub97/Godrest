//
//  LoginDataModel.swift
//  Godterest
//
//  Created by Varjeet Singh on 27/09/23.
//
import Foundation

// MARK: - LoginDataModel
struct LoginDataModel: Codable {
    let data: LoginDataClass?
    let status: String?
}

// MARK: - Datum
struct LoginDataClass: Codable {
    let childrenInFuture: String?
    let education: String?
    let creationTime: Int?
    let gender: String?
    let descriptions: String?
    let denomination: String?
    let password: String?
    let children: String?
    let tall: String?
    let id: Int?
    let email, profession: String?
    let alcohol: String?
    let address: Address?
    let profilePic: String?
    let smoke: String?
    let otherPic: String?
    let hobbies, dob, name, ethnicGroup: String?
    let maritalStatus: String?
    let addressID: Int?

    enum CodingKeys: String, CodingKey {
        case childrenInFuture, education, creationTime, gender, descriptions, denomination,  password, children,  tall, id, email, profession, alcohol, address, profilePic, smoke, otherPic, hobbies, dob, name, ethnicGroup, maritalStatus
        case addressID = "addressId"
    }
}



//["message": Login Succesfully, "status": 200, "userProfile": {
//    alcohol = "<null>";
//    children = "<null>";
//    childrenInFuture = "<null>";
//    countryCode = "+91";
//    creationTime = 1711203759511;
//    denomination = "<null>";
//    descriptions = "<null>";
//    dob = "<null>";
//    education = "<null>";
//    ethnicGroup = "<null>";
//    ethnicOrigin = "<null>";
//    gender = "<null>";
//    id = 108;
//    isAccountDeactivated = 0;
//    isAccountDeleted = 0;
//    isPhoneVerified = 1;
//    latitude = 0;
//    longitude = 0;
//    maritalStatus = "<null>";
//    name = "<null>";
//    otherPic = "<null>";
//    password = "";
//    phoneNumber = 9417909276;
//    profession = "<null>";
//    profilePic = "<null>";
//    reportedCount = "<null>";
//    smoke = "<null>";
//    studied = "<null>";
//    studiedAt = "<null>";
//    tall = "<null>";
//    updationTime = "<null>";
//}])
