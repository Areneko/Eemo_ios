//
//  UploadPhoto+ImagePickerController.swift
//  Eemo_ios
//
//  Created by Ren Matsushita on 2019/11/01.
//  Copyright © 2019 Ren Matsushita. All rights reserved.
//

import UIKit

extension UploadPhotoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let originalImage: UIImage = info[.originalImage] as? UIImage else { return }
        imageView.image = originalImage
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func pickImage(_ sourceType: UIImagePickerController.SourceType) {
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            let picker = UIImagePickerController()
            picker.sourceType = sourceType
            picker.delegate = self
            
            present(picker, animated: true, completion: nil)
        } else {
            // todo
            // アクセス権限のハンドリング
        }
    }
}
