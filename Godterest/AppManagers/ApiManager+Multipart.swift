//
//  ApiManager+Multipart.swift
//  Godterest
//
//  Created by Sandip Gill on 29/09/23.
//

import Alamofire
import Foundation

extension ApiManager {
    
    class func uploadS3BucketImage(_ url: String,
                                   dataToUpload: Data,
                                   completion: @escaping (_ result: [String: Any]?) -> Void) {
        if NetworkReachabilityManager()?.isReachable == false {
            completion(getNoInternetError())
            return
        }
        let url = URL(string: url)
        var request: NSMutableURLRequest? = nil
        if let url = url {
            request = NSMutableURLRequest(url: url)
        }
        request?.httpBody = dataToUpload
        request?.setValue("public-read", forHTTPHeaderField: "x-amz-acl")
        request?.setValue("image/png", forHTTPHeaderField: "Content-Type")
        request?.httpMethod = "PUT"
        let session = URLSession.shared
        let task1 = session.uploadTask(with: request! as URLRequest, from: dataToUpload) { _ , response, error in
            if error == nil {
                
            }
        }
        task1.resume()
    }
    
    class func multipartPost(_ urlRequest: URLRequest,
                             params: [String: Any] = [:],
                             dataToUpload: Data,
                             keyToUploadData: String,
                             fileNames: String,
                             headers: [String: String]? = nil,
                             completion: @escaping ([String: Any]?, T?) -> Void) {
        if NetworkReachabilityManager()?.isReachable == false {
            completion(getNoInternetError(), nil)
            return
        }
        
        let request = AF.upload(multipartFormData: { multipartFormData in
            for (key, value) in params {
                let valueStr = "\(value)"
                if let valueData = valueStr.data(using: .utf8) {
                    multipartFormData.append(valueData, withName: key)
                }
            }
            multipartFormData.append(dataToUpload,
                                     withName: keyToUploadData,
                                     fileName: fileNames,
                                     mimeType: "")
        }, with: urlRequest)
        
        request.uploadProgress { progress in
        }
        request.responseJSON { response in
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
        request.resume()
        //        }
    }
    
    class func multipartRequestSingleWithoutImage(_ url: String,
                                                  params: [String: Any] = [:],
                                                  dataToUpload: Data,
                                                  keyToUploadData: String,
                                                  fileNames: String,
                                                  headers: [String: String]? = nil,
                                                  completion: @escaping (_ result: [String: Any]?) -> Void) {
        if NetworkReachabilityManager()?.isReachable == false {
            completion(getNoInternetError())
            return
        }
        
        var httpHeaders: HTTPHeaders?
        if let headers = headers {
            httpHeaders = HTTPHeaders(headers)
        }
        
        if let urlRequest = try? URLRequest(url: url,
                                            method: .put,
                                            headers: httpHeaders) {
            print(params)
            print(urlRequest)
            let request = AF.upload(multipartFormData: { multipartFormData in
                for (key, value) in params {
                    let valueStr = "\(value)"
                    if let valueData = valueStr.data(using: .utf8) {
                        multipartFormData.append(valueData, withName: key)
                    }
                }
                //                multipartFormData.append(dataToUpload,
                //                                         withName: keyToUploadData,
                //                                         fileName: fileNames,
                //                                         mimeType: "")
            }, with: urlRequest)
            
            request.uploadProgress { progress in
            }
            request.responseJSON { response in
                DispatchQueue.main.async {
                    switch response.result {
                    case .success(let value):
                        guard let value = value as? [String: Any] else {
                            completion(self.getNoInternetError())
                            return
                        }
                        //                        print ("success")
                        //                        print("\(value)")
                        completion(value)
                    case .failure:
                        completion(self.getUnknownError(response.error?.localizedDescription))
                    }
                }
            }
            request.resume()
        }
    }
    
    class func multipartRequestSingle(_ url: String,
                                      params: [String: Any] = [:],
                                      dataToUpload: Data,
                                      keyToUploadData: String,
                                      fileNames: String,
                                      headers: [String: String]? = nil,
                                      completion: @escaping (_ result: [String: Any]?) -> Void) {
        if NetworkReachabilityManager()?.isReachable == false {
            completion(getNoInternetError())
            return
        }
        
        var httpHeaders: HTTPHeaders?
        if let headers = headers {
            httpHeaders = HTTPHeaders(headers)
        }
        
        if let urlRequest = try? URLRequest(url: url,
                                            method: .put,
                                            headers: httpHeaders) {
            print(params)
            print(urlRequest)
            let request = AF.upload(multipartFormData: { multipartFormData in
                for (key, value) in params {
                    let valueStr = "\(value)"
                    if let valueData = valueStr.data(using: .utf8) {
                        multipartFormData.append(valueData, withName: key)
                    }
                }
                multipartFormData.append(dataToUpload,
                                         withName: keyToUploadData,
                                         fileName: fileNames,
                                         mimeType: "")
            }, with: urlRequest)
            
            request.uploadProgress { progress in
            }
            request.responseJSON { response in
                DispatchQueue.main.async {
                    switch response.result {
                    case .success(let value):
                        guard let value = value as? [String: Any] else {
                            completion(self.getNoInternetError())
                            return
                        }
                        //                        print ("success")
                        //                        print("\(value)")
                        completion(value)
                    case .failure:
                        completion(self.getUnknownError(response.error?.localizedDescription))
                    }
                }
            }
            request.resume()
        }
    }
    
    class func multipartRequest(urlRequest: URLRequest,
                                params: [String: Any],
                                dataToUpload: [Data],
                                keyToUploadData: [String],
                                fileNames: [String],
                                mimeType: String,
                                headers: [String: String]? = nil,
                                completion: @escaping ([String: Any]?, T?) -> Void) {
        if NetworkReachabilityManager()?.isReachable == false {
            completion(getNoInternetError(), nil)
            return
        }
        
        let request = AF.upload(multipartFormData: { multipartFormData in
            for (key, value) in params {
                let valueStr = "\(value)"
                if let valueData = valueStr.data(using: .utf8) {
                    multipartFormData.append(valueData, withName: key)
                }
            }
            if !dataToUpload.isEmpty {
                for index in 0 ..< dataToUpload.count  {
                    let data = dataToUpload[index]
                    let key = keyToUploadData[index]
                    
                    let fileName = fileNames[index]
                    multipartFormData.append(data,
                                             withName: key,
                                             fileName: fileName,
                                             mimeType: mimeType)
                }
            }
        }, with: urlRequest)
        
        request.uploadProgress { progress in
        }
        request.responseJSON { response in
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
        request.resume()
    }
}
