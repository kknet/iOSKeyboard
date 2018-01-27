//
//  KeyboardViewController.swift
//  Pashto
//
//  Created by Maihan Nijat on 2018-01-20.
//  Copyright © 2018 Sunzala Technology. All rights reserved.
//

import UIKit
import AVFoundation

class KeyboardViewController: UIInputViewController {
    
    //MARK: - IBOUTLETS
    @IBOutlet var pashtoKeysView: UIView!
    @IBOutlet weak var pashtoKeysCapsView: UIView!
    @IBOutlet var symbolKeysView: UIView!
    @IBOutlet var nextKeyboardPashto: UIButton!
    @IBOutlet var nextKeyboardSybmols: UIButton!
    @IBOutlet weak var backSpacePashto: UIButton!
    @IBOutlet weak var symRow1: UIStackView!
    @IBOutlet weak var symRow2: UIStackView!
    @IBOutlet weak var symRow1B: UIStackView!
    @IBOutlet weak var symRow2B: UIStackView!
    
    //MARK: - Variables
    var timer: Timer?
    var shift = false
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        // Add custom view sizing constraints here
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "PashtoLatin", bundle: nil)
        let objects = nib.instantiate(withOwner: self, options: nil)
        view = objects[0] as! UIView
        
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(KeyboardViewController.handleBackSpace(_:)))
        backSpacePashto.addGestureRecognizer(longGesture)
        
        // Next keyboard
        self.nextKeyboardPashto.addTarget(self, action: #selector(handleInputModeList(from:with:)), for: .allTouchEvents)
        self.nextKeyboardSybmols.addTarget(self, action: #selector(handleInputModeList(from:with:)), for: .allTouchEvents)
    }
    
    override func textWillChange(_ textInput: UITextInput?) {
        // The app is about to change the document's contents. Perform any preparation here.
    }
    
    override func textDidChange(_ textInput: UITextInput?) {
        // The app has just changed the document's contents, the document context has been updated.
        
        var textColor: UIColor
        let proxy = self.textDocumentProxy
        if proxy.keyboardAppearance == UIKeyboardAppearance.dark {
            textColor = UIColor.white
        } else {
            textColor = UIColor.black
        }
        self.nextKeyboardPashto.setTitleColor(textColor, for: [])
        self.nextKeyboardSybmols.setTitleColor(textColor, for: [])
    }
    
    @IBAction func keyPressed(button: UIButton) {
        let string = button.titleLabel!.text
        (textDocumentProxy as UIKeyInput).insertText("\(string!)")
        AudioServicesPlaySystemSound(0x450);
        animateButton(button: button)
    }
    
    
    @IBAction func backSpacePressed(_ sender: UIButton) {
        (textDocumentProxy as UIKeyInput).deleteBackward()
        AudioServicesPlaySystemSound(1103);
        animateButton(button: sender)
    }
    
    @objc func handleBackSpace(_ gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.runTimer), userInfo: nil, repeats: true)
        }
        else if gesture.state == .ended {
            timer?.invalidate()
            timer = nil
        }
        
    }
    
    @objc func runTimer() {
        textDocumentProxy.deleteBackward()
        AudioServicesPlaySystemSound(1103);
    }
    
    @IBAction func spacePressed(button: UIButton) {
        (textDocumentProxy as UIKeyInput).insertText(" ")
        AudioServicesPlaySystemSound(1104);
        animateButton(button: button)
    }
    
    // Double touch
    @IBAction func dotWithSpace(_ sender: UITapGestureRecognizer) {
        (textDocumentProxy as UIKeyInput).insertText(".")
        AudioServicesPlaySystemSound(1104);
        (textDocumentProxy as UIKeyInput).insertText(" ")
        AudioServicesPlaySystemSound(1104);
    }
    
    @IBAction func returnPressed(button: UIButton) {
        (textDocumentProxy as UIKeyInput).insertText("\n")
        AudioServicesPlaySystemSound(0x450);
        animateButton(button: button)
    }
    
    @IBAction func numsPressed(button: UIButton) {
        AudioServicesPlaySystemSound(0x450);
        animateButton(button: button)
        pashtoKeysView.isHidden = true
        pashtoKeysCapsView.isHidden = true
        symbolKeysView.isHidden = false
    }
    
    @IBAction func symShiftPressed(_ sender: UIButton) {
        AudioServicesPlaySystemSound(0x450);
        animateButton(button: sender)
        if symRow1.isHidden {
            symRow1.isHidden = false
            symRow2.isHidden = false
            symRow1B.isHidden = true
            symRow2B.isHidden = true
            sender.titleLabel?.text = "۱۲۳"
        } else {
            symRow1.isHidden = true
            symRow2.isHidden = true
            symRow1B.isHidden = false
            symRow2B.isHidden = false
            sender.titleLabel?.text = "#+="
        }
    }
    
    @IBAction func pashtoKeysPressed(_ sender: UIButton) {
        AudioServicesPlaySystemSound(0x450);
        animateButton(button: sender)
        pashtoKeysView.isHidden = false
        pashtoKeysCapsView.isHidden = true
        symbolKeysView.isHidden = true
    }
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        AudioServicesPlaySystemSound(0x450);
        animateButton(button: sender)
    }
    
    // Shift, convert all keys to caps
    @IBAction func shiftPressed(_ sender: UIButton) {
        toggleCaps()
        AudioServicesPlaySystemSound(0x450);
        animateButton(button: sender)
    }
    
    // Convert buttons to caps
    func toggleCaps() {
        if !shift {
            pashtoKeysView.isHidden = true
            pashtoKeysCapsView.isHidden = false
            shift = true
        } else {
            pashtoKeysView.isHidden = false
            pashtoKeysCapsView.isHidden = true
            shift = false
        }
    }
    
    // Animation when key is pressed. Increase the scale of button
    func animateButton(button: UIButton) {
        
        UIView.animate(withDuration: 0.0, animations: {
            button.transform = CGAffineTransform.init(scaleX: 2.0, y: 2.0)
        }, completion: {(_) -> Void in
            button.transform =
                CGAffineTransform.init(scaleX: 1.0, y: 1.0)
        })
        
    }
}

