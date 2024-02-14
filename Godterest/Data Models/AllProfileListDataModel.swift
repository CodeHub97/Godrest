//
//  AllProfileListDataModel.swift
//  Godterest
//
//  Created by Varjeet Singh on 27/09/23.
//

import Foundation
// MARK: - AllProfileList
struct AllProfileList: Codable {
    let data: [ProfileDatum]?
    let status: String?
}

// MARK: - Datum
struct ProfileDatum: Codable {
    let childrenInFuture: String?
    let education: String?
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

    enum CodingKeys: String, CodingKey {
        case childrenInFuture, education, gender, descriptions
        case denomination, password, children,tall, id, email, profession, alcohol, address, profilePic, smoke, otherPic, hobbies, dob, name, ethnicGroup, maritalStatus
    }
}


