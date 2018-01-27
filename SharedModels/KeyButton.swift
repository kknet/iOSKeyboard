//
//  KeyButton.swift
//  Afghan Keyboard
//
//  Created by Maihan Nijat on 2018-01-21.
//  Copyright © 2018 Sunzala Technology. All rights reserved.
//

import UIKit

class KeyButton: UIButton {
    
    let themeKey = "themeKey"

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.layer.cornerRadius = 7
        
        guard let defaults = UserDefaults(suiteName: "group.com.sunzala.afghankeyboard") else { return }
        
        if let themeValue = defaults.string(forKey: themeKey) {
            if themeValue != "1" || themeValue == "" {
                
                // For all theme except first one
                self.layer.borderWidth = 1.0
                self.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.1).cgColor
                
                // For light themes
                if themeValue == "8" || themeValue == "12" || themeValue == "15" || themeValue == "16" || themeValue == "19" || themeValue == "20" {
                    self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.05)
                    self.setTitleColor(UIColor.darkGray, for: .normal)
                } else {
                    if self.currentImage == UIImage(named: "shift.png") {
                        guard let image = UIImage(named: "shift-white.png") else {return}
                        self.setImage(image, for: .normal)
                    }
                    if self.currentImage == UIImage(named: "backspace.png") {
                        guard let image = UIImage(named: "backspace-white.png") else {return}
                        self.setImage(image, for: .normal)
                    }
                    if self.currentImage == UIImage(named: "language.png") {
                        guard let image = UIImage(named: "language-white.png") else {return}
                        self.setImage(image, for: .normal)
                    }
                    if self.currentImage == UIImage(named: "return.png") {
                        guard let image = UIImage(named: "return-white.png") else {return}
                        self.setImage(image, for: .normal)
                    }
                    self.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.05)
                    self.setTitleColor(UIColor.white, for: .normal)
                }
            }
        }
        
    }

}
