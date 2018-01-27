//
//  ThemeKey.swift
//  Afghan Keyboard
//
//  Created by Maihan Nijat on 2018-01-22.
//  Copyright © 2018 Sunzala Technology. All rights reserved.
//

import UIKit

class ThemeKey: UIButton {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.layer.cornerRadius = 5
        self.setImage(UIImage(named: "check-mark.png"), for: .selected)
    }

}

