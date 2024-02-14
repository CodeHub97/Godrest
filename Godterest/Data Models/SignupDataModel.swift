//
//  SignupDataModel.swift
//  Godterest
//
//  Created by Varjeet Singh on 26/09/23.
//

import Foundation

// MARK: - UserSignup
struct UserSignup: Codable {
    let data: UserSignupDataClass
    let status: String?
}

// MARK: - DataClass
struct UserSignupDataClass: Codable {
    let childrenInFuture, education, gender: String?
    let descriptions: String?
    let denomination: String?
    let password, children: String?
    let tall, email, profession, alcohol: String?
    let address: Address
    let profilePic: String?
    let smoke: String?
    let otherPic: String?
    let hobbies: String?
    let dob, name, ethnicGroup, maritalStatus: String?

    enum CodingKeys: String, CodingKey {
        case childrenInFuture, education, gender, descriptions, denomination
        case password, children, tall, email, profession, alcohol, address, profilePic, smoke, otherPic, hobbies, dob, name, ethnicGroup, maritalStatus
    }
}

// MARK: - Address
struct Address: Codable {
    let country, emoji: String?
    let city: String?
    let latitude: Double?
    let timeZone: String?
    let emojiCode, street: String?
    let phoneCode: String?
    let state: String?
    let longitude: Double?

    enum CodingKeys: String, CodingKey {
        case country, emoji, city, latitude, timeZone
        case emojiCode, street, phoneCode, state, longitude
    }
}
