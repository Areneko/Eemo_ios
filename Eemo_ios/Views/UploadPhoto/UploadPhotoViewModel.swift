//
//  UploadPhotoViewModel.swift
//  Eemo_ios
//
//  Created by Ren Matsushita on 2019/10/31.
//  Copyright © 2019 Ren Matsushita. All rights reserved.
//

import UIKit

class UploadPhotoViewModel {
    
    var uploadImage: UIImage?
    
    private let notificationCenter = NotificationCenter.default
    
    init() {
        notificationCenter.addObserver(self, selector: #selector(upload), name: .uploadButtonClicked, object: nil)
    }
    
    @objc func upload(notification: Notification) {
        guard let uploadImageData = uploadImage?.jpegData(compressionQuality: 1.0) else { return }
        APIClient.uploadPhoto(photoData: uploadImageData,
                onSuccess: { emoText in
                    self.notificationCenter.post(name: .uploadSuccess, object: nil, userInfo: ["emoText": emoText])
                },
                onFailed: { error in
                    if let error = error as? Errors {
                        self.notificationCenter.post(name: .uploadFailed, object: nil, userInfo: ["errorText": error.errorText])
                    } else {
                        self.notificationCenter.post(name: .uploadFailed, object: nil, userInfo: ["errorText": "不明なエラーが発生しました。"])
                    }
                })
    }
}

extension Errors {
    var errorText: String {
        switch self {
        case .decodeError:
            return "デコードに失敗しました。"
        case .emptyData:
            return "エモテキストの生成に失敗しました。"
        case .unknown:
            return "サーバートノツウシンニシッパイシマシタ"
        }
    }
}
