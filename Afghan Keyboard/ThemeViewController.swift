//
//  ThemeViewController.swift
//  Afghan Keyboard
//
//  Created by Maihan Nijat on 2018-01-21.
//  Copyright © 2018 Sunzala Technology. All rights reserved.
//

import UIKit
import GoogleMobileAds

class ThemeViewController: UIViewController, GADInterstitialDelegate, GADBannerViewDelegate {
    
    //MARK: - IBOutlets
    @IBOutlet var buttons: [UIButton]!
    @IBOutlet weak var bannerView: GADBannerView!
    
    //MARK: - Variables
    let themeKey = "themeKey"
    var interstitial: GADInterstitial!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = UserDefaults(suiteName: "group.com.sunzala.afghankeyboard")
        if defaults != nil {
            if let themeValue = defaults!.string(forKey: themeKey) {
                if let themeNumber = Int(themeValue) {
                    buttons[themeNumber - 1].isSelected = true
                }
            } else {
                buttons[0].isSelected = true
            }
        }
        
        // Load ad
        interstitialAd()
        
        // Load banner ad
        let bannerAd = Ad(adView: bannerView, parentController: self)
        bannerAd.loadAd(testing: true)
        bannerView.delegate = self
    }
    
    // Load full screen ad
    func interstitialAd(){
        let request = GADRequest()
        interstitial = GADInterstitial(adUnitID: "ca-app-pub-6404264627814552/6477866379")
        request.testDevices = ["b285e2de2a9acf7444baa910e45c61e5"]
        interstitial.load(request)
        interstitial.delegate = self
    }
    
    func interstitialDidReceiveAd(_ ad: GADInterstitial) {
        if interstitial.isReady {
            interstitial.present(fromRootViewController: self)
            print("sh")
        }
        
        print("rece")
    }
    
    //MARK: - Theme Functions
    @IBAction func selectTheme1(_ sender: UIButton) {
        saveUserDefaults(value: "1", button: sender)
    }
    
    @IBAction func selectTheme2(_ sender: UIButton) {
        saveUserDefaults(value: "2", button: sender)
    }
    
    @IBAction func selectTheme3(_ sender: UIButton) {
        saveUserDefaults(value: "3", button: sender)
    }
    
    @IBAction func selectTheme4(_ sender: UIButton) {
        saveUserDefaults(value: "4", button: sender)
    }
    
    @IBAction func selectTheme5(_ sender: UIButton) {
        saveUserDefaults(value: "5", button: sender)
    }
    
    @IBAction func selectTheme6(_ sender: UIButton) {
        saveUserDefaults(value: "6", button: sender)
    }
    
    @IBAction func selectTheme7(_ sender: UIButton) {
        saveUserDefaults(value: "7", button: sender)
    }
    
    @IBAction func selectTheme8(_ sender: UIButton) {
        saveUserDefaults(value: "8", button: sender)
    }
    
    @IBAction func selectTheme9(_ sender: UIButton) {
        saveUserDefaults(value: "9", button: sender)
    }
    
    @IBAction func selectTheme10(_ sender: UIButton) {
        saveUserDefaults(value: "10", button: sender)
    }
    
    @IBAction func selectTheme11(_ sender: UIButton) {
        saveUserDefaults(value: "11", button: sender)
    }
    
    @IBAction func selectTheme12(_ sender: UIButton) {
        saveUserDefaults(value: "12", button: sender)
    }
    
    @IBAction func selectTheme13(_ sender: UIButton) {
        saveUserDefaults(value: "13", button: sender)
    }
    
    @IBAction func selectThem14(_ sender: UIButton) {
        saveUserDefaults(value: "14", button: sender)
    }
    
    @IBAction func selectTheme15(_ sender: UIButton) {
        saveUserDefaults(value: "15", button: sender)
    }
    
    @IBAction func selectTheme16(_ sender: UIButton) {
        saveUserDefaults(value: "16", button: sender)
    }
    
    @IBAction func selectTheme17(_ sender: UIButton) {
        saveUserDefaults(value: "17", button: sender)
    }
    
    @IBAction func selectTheme18(_ sender: UIButton) {
        saveUserDefaults(value: "18", button: sender)
    }
    
    @IBAction func selectTheme19(_ sender: UIButton) {
        saveUserDefaults(value: "19", button: sender)
    }
    
    @IBAction func selectTheme20(_ sender: UIButton) {
        saveUserDefaults(value: "20", button: sender)
    }
    
    @IBAction func selectTheme21(_ sender: UIButton) {
        saveUserDefaults(value: "21", button: sender)
    }
    
    @IBAction func selectTheme22(_ sender: UIButton) {
        saveUserDefaults(value: "22", button: sender)
    }
    
    @IBAction func selectTheme23(_ sender: UIButton) {
        saveUserDefaults(value: "23", button: sender)
    }
    
    @IBAction func selectTheme24(_ sender: UIButton) {
        saveUserDefaults(value: "24", button: sender)
    }
    
    // Save theme key to user defaults
    func saveUserDefaults(value: String, button: UIButton){
        guard let defaults = UserDefaults(suiteName: "group.com.sunzala.afghankeyboard") else { return }
        defaults.set(value, forKey: themeKey)
        defaults.synchronize()
        
        // Call removeSelected method
        removeSelected()
        
        // Applu check mark to the button
        button.isSelected = true
    }
    
    // Remove selected state from all buttons
    func removeSelected() {
        for button in buttons {
            button.isSelected = false
        }
    }
}
