//
//  APIManager.swift
//  Godterest
//
//  Created by Sandip Gill on 29/09/23.
//

import UIKit
import Alamofire
import UIKit

class ApiManager<T: Codable>: BaseApiManager {
    
    class func makeApiCall(url: String,
                           params: [String: Any] = [:],
                           headers: [String: String]? = nil,
                           method: HTTPMethod = .post,
                           completion: @escaping ([String: Any]?, T?) -> Void) {

        let dataRequest = self.getDataRequest(url: url,
                                              params: params,
                                              method: method,
                                              headers: headers)
        self.executeDataRequest(dataRequest, with: completion)
    }
    
    class func makeUploadRequest(url: String,
                                 params: [String: Any] = [:],
                                 fileData: Data?,
                                 keyName: String,
                                 mimeType: String,
                                 fileExtension: String,
                                 headers: [String: String]? = nil,
                                 method: HTTPMethod = .post,
                                 completion: @escaping ([String: Any]?, T?) -> Void) {

        let dataRequest = self.getUrlRequest(urlStr: url)
        let name = "\(Int64((Date().timeIntervalSince1970 * 1000.0).rounded())).\(fileExtension)"
        let fileArray = fileData == nil ? []:[fileData!]
        self.multipartRequest(urlRequest: dataRequest, params: params, dataToUpload: fileArray, keyToUploadData: [keyName], fileNames: [name], mimeType: mimeType, completion: completion)
    }
    
    static func executeDataRequest(_ dataRequest: DataRequest,
                                   with completion: @escaping (_ result: [String: Any]?, _ model: T?) -> Void) {
        if ApiManager.isNetworkReachable == false {
            completion(getNoInternetError(), nil)
            return
        }
        dataRequest.responseJSON { response in
            DispatchQueue.main.async {
                switch response.result {
                case .success(let value):
                    guard let value = value as? [String: Any] else {
                        completion(self.getUnknownError(response.error?.localizedDescription), nil)
                        return
                    }
                print("Response--------->>>>>>>","\(value)")
                    do {
                        guard let data = response.data else {completion(value, nil)
                            return
                        }
                        let user = try JSONDecoder().decode(T.self, from: data)
                        let statusCode = value["statusCode"] as? Int
                        let message = value["message"] as? String ?? "Something went wrong!"
                        if statusCode == 401 {
//                            Progress.shared.hide()
//                            AlertViewManager.showAlert(message: message, alertButtonTypes: [.okay], alertStyle: .alert) { _ in
//                                AppManager.shared.setConfigAsRoot()
//                            }
                        } else {
                            completion(value, user)
                        }
                    } catch let error {
                        print("error------------->>>>>",error.localizedDescription)
                        completion(self.getUnknownError(error.localizedDescription), nil)
                    }
                case .failure (let error):
                    print("error------------->>>>>",error.localizedDescription)
                    completion(self.getUnknownError(error.localizedDescription), nil)
                }
            }
        }
    }
}

class BaseApiManager: NSObject {
    
    class var isNetworkReachable: Bool {
        return NetworkReachabilityManager()?.isReachable == true
    }
    
    static  let shared = BaseApiManager()

    let sessionManager: Session = {
       
        let manager = ServerTrustManager(evaluators: [APIConstants.baseUrl: DisabledTrustEvaluator()])
        let configuration = URLSessionConfiguration.af.default

        return Session(configuration: configuration, serverTrustManager: manager)
    }()

    class func getDataRequest(url: String,
                              params: [String: Any] = [:],
                              method: HTTPMethod = .post,
                              headers: [String: String]? = nil) -> DataRequest {
        let encoding: ParameterEncoding = method == .get ? URLEncoding(destination: .queryString) : JSONEncoding.default

        debugPrint("URL", url)
        debugPrint("Params", params)
        var httpHeaders: HTTPHeaders?
        if let headers = headers {
            httpHeaders = HTTPHeaders(headers)
        }
        let dataRequest: DataRequest
        dataRequest = AF.request(url,
                                     method: method,
                                     parameters: params,
                                     encoding: encoding,
                                     headers: httpHeaders)
        return dataRequest
    }
    
    class func getUrlRequest(urlStr: String) -> URLRequest {
        let url = URL(string: urlStr)!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        return urlRequest
    }
}

extension BaseApiManager {

    static func getNoInternetError() -> [String: Any] {
        return [APIKeys.message: "Something went wrong!",
                APIKeys.statusCode: 503]
    }

    static func getUnknownError(_ message: String? = nil) -> [String: Any] {
        if !isNetworkReachable {
            return getNoInternetError()
        } else {
            return [APIKeys.message: message ?? "Inernal server error!",
                    APIKeys.statusCode: 503]
        }
    }
}

