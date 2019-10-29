//
//  ResultViewController.swift
//  Eemo_ios
//
//  Created by Ren Matsushita on 2019/10/28.
//  Copyright © 2019 Ren Matsushita. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    
    @IBOutlet private weak var emoImageView: UIImageView!
    var originalImage: UIImage?
    var emoText: String?
    
    @IBOutlet private weak var twitterShareButton: UIButton!
    @IBOutlet private weak var facebookShareButton: UIButton!
    @IBOutlet private weak var instagramShareButton: UIButton!
    
    @IBOutlet private weak var savePhotoButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    private func configure() {
        emoImageView.image = originalImage
        emoImageView.clipsToBounds = true
        emoImageView.layer.cornerRadius = 5
        emoImageView.emo(emoText: emoText!)
    }
}
