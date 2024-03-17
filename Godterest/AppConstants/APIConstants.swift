//
//  APIConstants.swift
//  Fitsentive
//
//  Created by Sandip Gill
//

import Foundation
import UIKit

struct APIConstants {
    
    static let deviceType = "IOS"
    static let baseUrl = "http://3.230.250.53:8081/api" // sandbox
    static let s3BucketUrl = "https://app-aasets.s3.us-east-1.amazonaws.com/"
    struct EndPoints {
        static let profile = baseUrl + "/user/user-profiles"
        static let reportUser = baseUrl + "/user/report-user-profiles"
        static let blockUser = baseUrl + "/user/block-user-profiles"
        static let verify  = baseUrl + "/api/user/verify-user"
    }
}
