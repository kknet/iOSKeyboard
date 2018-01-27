//
//  ViewController.swift
//  Afghan Keyboard
//
//  Created by Maihan Nijat on 2018-01-20.
//  Copyright © 2018 Sunzala Technology. All rights reserved.
//

import UIKit
import GoogleMobileAds

class ViewController: UIViewController, GADBannerViewDelegate {
    
    @IBOutlet weak var bannerView: GADBannerView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.barTintColor = UIColor(red: 0.2431, green: 0.7255, blue: 0.9059, alpha: 1.0)
        navigationController?.navigationBar.tintColor = UIColor.white
        
        // Load ad
        let bannerAd = Ad(adView: bannerView, parentController: self)
        bannerAd.loadAd(testing: true)
        bannerView.delegate = self
    }
}

