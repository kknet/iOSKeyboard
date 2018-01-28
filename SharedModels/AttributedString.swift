//
//  AttributedString.swift
//  Afghan Keyboard
//
//  Created by Maihan Nijat on 2018-01-28.
//  Copyright © 2018 Sunzala Technology. All rights reserved.
//

import UIKit

class AttributedString: NSAttributedString {
    
    let themeKey = "themeKey"
    var textColor: UIColor?
    
    override init() {
        super.init()
        
        guard let defaults = UserDefaults(suiteName: "group.com.sunzala.afghankeyboard") else { return }
        
        if let themeValue = defaults.string(forKey: themeKey) {
            if themeValue == "1" || themeValue == "8" || themeValue == "12" || themeValue == "15" || themeValue == "16" || themeValue == "19" || themeValue == "20" {
                textColor = UIColor.black
            } else {
                textColor = UIColor.white
            }
        } else {
            textColor = UIColor.black
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // SuperScript text on the button
    func setSuperScript(text: String, button: KeyButton, fontSize: Int) {
        let font:UIFont? = UIFont.systemFont(ofSize: 22, weight: UIFont.Weight.light)
        let fontSuper:UIFont? = UIFont(name: "Helvetica", size:CGFloat(fontSize))
        let attString:NSMutableAttributedString = NSMutableAttributedString(string: text, attributes: [.font:font!, .foregroundColor: textColor!])
        attString.setAttributes([.font:fontSuper!,.baselineOffset:15, .foregroundColor: textColor!,], range: NSRange(location:1,length:1))
        button.setAttributedTitle(attString, for: .normal)
    }

}
