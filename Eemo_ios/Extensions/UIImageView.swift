//
//  UIImageView.swift
//  Eemo_ios
//
//  Created by Ren Matsushita on 2019/10/28.
//  Copyright © 2019 Ren Matsushita. All rights reserved.
//

import UIKit

extension UIImageView {
    func emo(emoText: String) {
        let emoLabel = UILabel()
        emoLabel.center = self.center
        emoLabel.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        emoLabel.text = emoText
        emoLabel.textColor = .black
        emoLabel.sizeToFit()
        self.addSubview(emoLabel)
    }
    
    func adjustTextColor() -> UIColor {
        return .white
    }
}
