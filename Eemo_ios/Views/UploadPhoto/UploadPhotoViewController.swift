//
//  UploadPhotoViewController.swift
//  Eemo_ios
//
//  Created by Ren Matsushita on 2019/10/28.
//  Copyright © 2019 Ren Matsushita. All rights reserved.
//

import UIKit

class UploadPhotoViewController: UIViewController {

    @IBOutlet private weak var imageView: UIImageView!

    @IBOutlet private weak var pickButton: UIButton!
    @IBOutlet private weak var uploadButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
    
        configure()
    }

    private func configure() {
        navigationItem.title = "Eemo"
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont(name: "Zapfino", size: 18)!
        ]
    
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 5
    }
}
