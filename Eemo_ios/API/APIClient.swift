//
//  Post.swift
//  Eemo_ios
//
//  Created by Ren Matsushita on 2019/10/28.
//  Copyright © 2019 Ren Matsushita. All rights reserved.
//

import Foundation

class APIClient {
    typealias UploadSuccess = (String) -> Void
    typealias UploadFailed = (Error) -> Void
    
    static func uploadPhoto(photoData: Data, onSuccess: @escaping UploadSuccess, onFailed: @escaping UploadFailed) {
        let filename = "original.jpg"
        let boundary = UUID().uuidString
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)

        var urlRequest = URLRequest(url: URL(string: "https://eemo-backend.herokuapp.com/api/generate")!)
        urlRequest.httpMethod = "POST"

        urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        var data = Data()

        data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
        data.append("Content-Disposition: form-data; name=\"file\"; filename=\"\(filename)\"\r\n".data(using: .utf8)!)
        data.append("Content-Type: image/jpg\r\n\r\n".data(using: .utf8)!)
        data.append(photoData)
        
        data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)

        session.uploadTask(with: urlRequest, from: data, completionHandler: { responseData, res, error in
            
            guard let res = res as? HTTPURLResponse else { return }
            
            if res.statusCode >= 400 {
                onFailed(Errors.unknown)
                return
            }
            
            if error != nil {
                onFailed(Errors.unknown)
                return
            }
            
            guard let responseData = responseData else {
                onFailed(Errors.emptyData)
                return
            }
            
            if let responseString = String(data: responseData, encoding: .utf8) {
                onSuccess(responseString)
            }
        }).resume()
    }
}

struct EmoTextObject: Decodable {
    //エモいテキスト
    let data: String
}

enum Errors: Error {
    case decodeError
    case emptyData
    // Todo
    // エラーハンドリングをまだ済ませていない
    case unknown
}
