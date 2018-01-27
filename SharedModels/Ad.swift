//
//  Ad.swift
//  Afghan Keyboard
//
//  Created by Maihan Nijat on 2018-01-22.
//  Copyright © 2018 Sunzala Technology. All rights reserved.
//

import GoogleMobileAds

class Ad {
    
    // Parent Controller and Ad View required for class
    let parentController: UIViewController
    let adView: GADBannerView
    
    let request = GADRequest()
    
    init(adView: GADBannerView, parentController: UIViewController) {
        self.adView = adView
        self.parentController = parentController
        adView.adUnitID = "ca-app-pub-6404264627814552/9678744784"
        adView.rootViewController = parentController
    }
    
    // Load the ad and set the test device.
    func loadAd(testing: Bool){
        if testing {
            request.testDevices = ["b285e2de2a9acf7444baa910e45c61e5"]
        }
        adView.load(request)
    }
}
