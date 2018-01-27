//
//  KeysView.swift
//  Afghan Keyboard
//
//  Created by Maihan Nijat on 2018-01-21.
//  Copyright © 2018 Sunzala Technology. All rights reserved.
//

import UIKit

class ImageView: UIImageView {
    
    let themeKey = "themeKey"
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
                
        guard let defaults = UserDefaults(suiteName: "group.com.sunzala.afghankeyboard") else { return }
        
        if let themeValue = defaults.string(forKey: themeKey) {
            if themeValue != "1" || themeValue != "" {
                if let image = UIImage(named: "\(themeValue).jpg") {
                    self.image = image
                }
            } else {
                self.isHidden = true
            }
        }
    }
    
}
