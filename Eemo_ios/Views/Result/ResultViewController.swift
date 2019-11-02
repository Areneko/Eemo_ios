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
    
    @IBOutlet private weak var shareButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    @IBAction private func shere() {
        let text: String = "「\(emoText!)」"
        let shareItems: [Any] = [text, getScreenShot()]
        let activityViewController = UIActivityViewController(
            activityItems: shareItems, applicationActivities: nil)
        present(activityViewController, animated: true, completion: nil)
    }
    
    @IBAction private func dismiss() {
        dismiss(animated: true, completion: nil)
    }
    
    private func getScreenShot() -> UIImage {
        self.shareButton.isHidden = true
        UIGraphicsBeginImageContextWithOptions(emoImageView.bounds.size, false, 0.0)
        self.view.drawHierarchy(in: self.emoImageView.bounds, afterScreenUpdates: true)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        self.shareButton.isHidden = false
        return image
    }
    
    private func configure() {
        emoImageView.image = originalImage
        emoImageView.emo(emoText: emoText!, frame: view.frame)
        
        shareButton.clipsToBounds = true
        shareButton.layer.cornerRadius = shareButton.frame.height / 2
    }
}
