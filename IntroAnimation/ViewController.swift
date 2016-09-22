//
//  ViewController.swift
//  IntroAnimation
//
//  Created by Rickey Hrabowskie on 9/21/16.
//  Copyright © 2016 Rickey Hrabowskie. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var bottomLayoutConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureAssets()
        
        passwordTextField.delegate = self 
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardDidHide, object: nil)
        
        introAnimation()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        
        NotificationCenter.default.removeObserver(self)
        
    }
    func configureAssets() {
        
        self.titleLabel.alpha = 0.0
        self.usernameTextField.alpha = 0.0
        self.passwordTextField.alpha = 0.0
        
        self.signInButton.isHidden = true
        self.signInButton.center.y += self.signInButton.frame.height
        
        self.usernameTextField.center.y += -20 // 20 points above current
        self.passwordTextField.center.y += -20
    }
    
    func fadeInAssets() {
        
        self.titleLabel.alpha = 1.0
        self.usernameTextField.alpha = 1.0
        self.passwordTextField.alpha = 1.0
    }
    
    func animateTextFields() {
        
        self.usernameTextField.center.y -= -20
        self.passwordTextField.center.y -= -20
    }
    
    func introAnimation() {
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: { 
            self.fadeInAssets()
            self.animateTextFields()
            }, completion: nil)
    }
    
    func showSignInButton() {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: { 
            self.signInButton.isHidden = false
            self.signInButton.center.y -= self.signInButton.frame.height
            
            }, completion: nil)
    }
    
    func keyboardWillShow(_ n:Notification) {
        
        if let userInfo = n.userInfo {
            if let keyboardSize = (userInfo[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
                
                self.bottomLayoutConstraint.constant = keyboardSize.height
                self.view.layoutIfNeeded() // Fixes the sign in button lag 
            }
        }
    }
    
    func keyboardWillHide(_ n:Notification) {
        
        self.bottomLayoutConstraint.constant = 0
        self.view.layoutIfNeeded()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.tag == 1 {
            //show sign in button
            self.showSignInButton()
        }
    }
}

