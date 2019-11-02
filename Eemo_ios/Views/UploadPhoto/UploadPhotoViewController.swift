//
//  UploadPhotoViewController.swift
//  Eemo_ios
//
//  Created by Ren Matsushita on 2019/10/28.
//  Copyright © 2019 Ren Matsushita. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class UploadPhotoViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    private lazy var indicator = NVActivityIndicatorView(
        frame: CGRect(x: view.frame.width / 2 - 75, y: view.frame.height / 2 - 75, width: 150, height: 150),
        type: .ballScale,
        color: .cyan,
        padding: 0
    )

    @IBOutlet private weak var pickButton: UIButton!
    @IBOutlet private weak var uploadButton: UIButton!
    
    let notificationCenter = NotificationCenter.default
    let viewModel = UploadPhotoViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        notificationCenter.addObserver(self, selector: #selector(uploadSuccess), name: .uploadSuccess, object: nil)
        notificationCenter.addObserver(self, selector: #selector(uploadFailed), name: .uploadFailed, object: nil)
        
        configure()
    }
    
    @objc func uploadSuccess(notification: Notification) {
        guard let emoText = notification.userInfo?["emoText"] else { return }
        guard emoText is String else { return }
        
        DispatchQueue.main.async {
            self.indicator.stopAnimating()
            self.uploadButton.isEnabled = true
            let storyboard = UIStoryboard(name: "Result", bundle: nil)
            guard let resultViewController = storyboard.instantiateViewController(identifier: "Result") as? ResultViewController else { return }
            resultViewController.emoText = emoText as? String
            resultViewController.originalImage = self.imageView.image
            resultViewController.modalPresentationStyle = .fullScreen
            self.present(resultViewController, animated: true, completion: nil)
        }
    }
    
    @objc func uploadFailed(notification: Notification) {
        guard let errorText = notification.userInfo?["errorText"] else { return }
        guard errorText is String else { return }
        
        DispatchQueue.main.async {
            self.indicator.stopAnimating()
            self.uploadButton.isEnabled = true
            let alert = UIAlertController(title: "「エモ」を作ることができませんでした...", message: errorText as? String, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func pickImage() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "カメラ", style: .default, handler: { _ in self.pickImage(.camera)}))
        alert.addAction(UIAlertAction(title: "フォトライブラリ", style: .default, handler: { _ in self.pickImage(.photoLibrary)}))
        alert.addAction(UIAlertAction(title: "キャンセル", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func upload() {
        indicator.startAnimating()
        uploadButton.isEnabled = false
        viewModel.uploadImage = imageView.image
        notificationCenter.post(Notification(name: .uploadButtonClicked))
    }
    
    private func configure() {
        navigationItem.title = "Eemo"
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont(name: "Zapfino", size: 18)!
        ]
        
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 5
        
        view.addSubview(indicator)
        
        uploadButton.layer.cornerRadius = uploadButton.frame.height / 2
        uploadButton.clipsToBounds = true
        
        pickButton.layer.cornerRadius = pickButton.frame.height / 2
        pickButton.clipsToBounds = true
    }
}
