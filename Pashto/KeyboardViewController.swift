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
    @IBOutlet var symbolKeysView: UIView!
    @IBOutlet var nextKeyboardPashto: UIButton!
    @IBOutlet var nextKeyboardSybmols: UIButton!
    @IBOutlet weak var backSpacePashto: UIButton!
    @IBOutlet weak var symRow1: UIStackView!
    @IBOutlet weak var symRow2: UIStackView!
    @IBOutlet weak var symRow1B: UIStackView!
    @IBOutlet weak var symRow2B: UIStackView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var ye1: KeyButton!
    @IBOutlet weak var ye2: KeyButton!
    @IBOutlet weak var swat: KeyButton!
    @IBOutlet weak var tway: KeyButton!
    @IBOutlet weak var wow: KeyButton!
    @IBOutlet weak var noon: KeyButton!
    
    //MARK: - Variables
    var timer: Timer?
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        // Add custom view sizing constraints here
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "PashtoKeyboard", bundle: nil)
        let objects = nib.instantiate(withOwner: self, options: nil)
        view = objects[0] as! UIView
        
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(KeyboardViewController.handleBackSpace(_:)))
        backSpacePashto.addGestureRecognizer(longGesture)
        
        // Next keyboard
        self.nextKeyboardPashto.addTarget(self, action: #selector(handleInputModeList(from:with:)), for: .allTouchEvents)
        self.nextKeyboardSybmols.addTarget(self, action: #selector(handleInputModeList(from:with:)), for: .allTouchEvents)
        
        // Subscript text on the button
        superScriptText(text: "يئ", button: ye1, fontSize: 12)
        superScriptText(text: "‌ۍی", button: ye2, fontSize: 12)
        superScriptText(text: "صض", button: swat, fontSize: 6)
        superScriptText(text: "طظ", button: tway, fontSize: 12)
        superScriptText(text: "وؤ", button: wow, fontSize: 12)
        superScriptText(text: "نڼ", button: noon, fontSize: 12)
    }
    
    // SuperScript text on the button
    func superScriptText(text: String, button: KeyButton, fontSize: Int) {
        let font:UIFont? = UIFont.systemFont(ofSize: 22, weight: UIFont.Weight.light)
        let fontSuper:UIFont? = UIFont(name: "Helvetica", size:CGFloat(fontSize))
        let attString:NSMutableAttributedString = NSMutableAttributedString(string: text, attributes: [.font:font!])
        attString.setAttributes([.font:fontSuper!,.baselineOffset:15], range: NSRange(location:1,length:1))
        button.setAttributedTitle(attString, for: .normal)
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
        animateButton(button: button)
        let string = button.titleLabel!.text
        if string == "صض" {
            (textDocumentProxy as UIKeyInput).insertText("ص")
        } else if string == "‌ۍی" {
            (textDocumentProxy as UIKeyInput).insertText("ی")
        } else if string == "يئ" {
            (textDocumentProxy as UIKeyInput).insertText("ي")
        } else if string == "طظ" {
            (textDocumentProxy as UIKeyInput).insertText("ط")
        } else if string == "وؤ" {
            (textDocumentProxy as UIKeyInput).insertText("و")
        } else if string == "نڼ" {
            (textDocumentProxy as UIKeyInput).insertText("ن")
        } else {
            (textDocumentProxy as UIKeyInput).insertText("\(string!)")
        }
        AudioServicesPlaySystemSound(0x450);
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
        symbolKeysView.isHidden = true
    }
    
    @IBAction func zeroWidthPressed(_ sender: UIButton) {
        (textDocumentProxy as UIKeyInput).insertText("\u{200B}")
        AudioServicesPlaySystemSound(0x450);
        animateButton(button: sender)
    }
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        AudioServicesPlaySystemSound(0x450);
        animateButton(button: sender)
    }
    
    // Long press touch
    @IBAction func insertDwat(_ sender: UILongPressGestureRecognizer) {
        insertWithLongPress(sender: sender, key: "ض")
    }
    
    @IBAction func insertNon(_ sender: UILongPressGestureRecognizer) {
        insertWithLongPress(sender: sender, key: "ڼ")
    }
    
    @IBAction func insertYe1(_ sender: UILongPressGestureRecognizer) {
        insertWithLongPress(sender: sender, key: "ئ")
    }
    
    @IBAction func insertYe2(_ sender: UILongPressGestureRecognizer) {
        insertWithLongPress(sender: sender, key: "ۍ")
    }
    
    @IBAction func insertWow(_ sender: UILongPressGestureRecognizer) {
        insertWithLongPress(sender: sender, key: "ؤ")
    }
    
    @IBAction func insertTway(_ sender: UILongPressGestureRecognizer) {
        insertWithLongPress(sender: sender, key: "ظ")
    }
    
    // Long Press method
    func insertWithLongPress(sender: UILongPressGestureRecognizer, key: String){
        if sender.state == .began {
            (textDocumentProxy as UIKeyInput).insertText(key)
            AudioServicesPlaySystemSound(0x450);
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
