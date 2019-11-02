//
//  UIImageView.swift
//  Eemo_ios
//
//  Created by Ren Matsushita on 2019/10/28.
//  Copyright © 2019 Ren Matsushita. All rights reserved.
//

import UIKit

extension UIImageView {
    func emo(emoText: String, frame: CGRect) {
        let emoLabel = UILabel(frame: frame)
        print(self.frame)
        emoLabel.numberOfLines = 0
        emoLabel.textAlignment = .center
        emoLabel.font = UIFont.systemFont(ofSize: 30, weight: .heavy)
        emoLabel.text = emoText
        emoLabel.textColor = .white
        
        addSubview(emoLabel)
    }
    
    func adjustTextColor() -> UIColor {
        return .white
    }
}
