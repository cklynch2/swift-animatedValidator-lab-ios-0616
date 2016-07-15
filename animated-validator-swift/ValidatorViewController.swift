//
//  ValidatorViewController.swift
//  animated-validator-swift
//
//  Created by Flatiron School on 6/27/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ValidatorViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailConfirmationTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordConfirmTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view, typically from a nib.
        self.submitButton.accessibilityLabel = Constants.SUBMITBUTTON
        self.emailTextField.accessibilityLabel = Constants.EMAILTEXTFIELD
        self.emailConfirmationTextField.accessibilityLabel = Constants.EMAILCONFIRMTEXTFIELD
        self.phoneTextField.accessibilityLabel = Constants.PHONETEXTFIELD
        self.passwordTextField.accessibilityLabel = Constants.PASSWORDTEXTFIELD
        self.passwordConfirmTextField.accessibilityLabel = Constants.PASSWORDCONFIRMTEXTFIELD
        
        self.submitButton.enabled = false
        
        self.view.removeConstraints(self.view.constraints)
        setPortraitConstraints()

// You would use the following if "listening" to textField entries through delegate methods rather than through IBActions...
//        emailTextField.delegate = self
//        emailConfirmationTextField.delegate = self
//        phoneTextField.delegate = self
//        passwordTextField.delegate = self
//        passwordConfirmTextField.delegate = self
    }
    
    func invalidTextFieldPulse(textField: UITextField, validation: Bool) {
        if !validation {
            UIView.animateWithDuration(0.25, delay: 0, options: [.Autoreverse, .Repeat], animations: {
                
                UIView.setAnimationRepeatCount(3.0)
                
                // This transform will cause the textField to pulse between its original dimensions and 95% of its x and y dimensions.
                textField.transform = CGAffineTransformMakeScale(0.95, 0.95)
                textField.backgroundColor = UIColor.redColor()
                self.view.layoutIfNeeded()
                
                // This is a completion clause that says the textField should return to its original dimensions when the animation is done.
            }) { (true) in
                textField.transform = CGAffineTransformMakeScale(1.0, 1.0)
            }
        } else {
            textField.backgroundColor = UIColor.whiteColor()
        }
    }
    
    func enableSubmit() {
        if allFieldsValid() {
            submitButton.enabled = true
        }
    }

    @IBAction func emailEntered(sender: AnyObject) {
        invalidTextFieldPulse(emailTextField, validation: validEmail())
        enableSubmit()
    }
    
    @IBAction func confirmEmailEntered(sender: AnyObject) {
        invalidTextFieldPulse(emailConfirmationTextField, validation: validEmailConfirmation())
        enableSubmit()
    }
    
    @IBAction func phoneEntered(sender: AnyObject) {
        invalidTextFieldPulse(phoneTextField, validation: validPhone())
        enableSubmit()
    }
    
    @IBAction func passwordEntered(sender: AnyObject) {
        invalidTextFieldPulse(passwordTextField, validation: validPassword())
        enableSubmit()
    }
    
    @IBAction func confirmPasswordEntered(sender: AnyObject) {
        invalidTextFieldPulse(passwordConfirmTextField, validation: validPasswordConfirmation())
        enableSubmit()
    }

    func validEmail() -> Bool {
        if let emailText = emailTextField.text {
            return emailText.containsString("@") && emailText.containsString(".")
        }
        return false
    }
    
    func validEmailConfirmation() -> Bool {
        return emailConfirmationTextField.text == emailTextField.text
    }
        
    func validPhone() -> Bool {
        let invalid = NSCharacterSet.decimalDigitCharacterSet().invertedSet
        
        if let phoneText = phoneTextField.text {
            return phoneText.characters.count >= 7 && phoneText.rangeOfCharacterFromSet(invalid) == nil
        }
        return false
    }

    func validPassword() -> Bool {
        return passwordTextField.text?.characters.count >= 6
    }
    
    func validPasswordConfirmation() -> Bool {
        return passwordTextField.text == passwordConfirmTextField.text
    }
    
    func allFieldsValid() -> Bool {
        return validEmail() && validEmailConfirmation() && validPhone() && validPassword() && validPasswordConfirmation()
    }
    
    func setPortraitConstraints() {
        self.emailTextField.translatesAutoresizingMaskIntoConstraints = false
        self.emailConfirmationTextField.translatesAutoresizingMaskIntoConstraints = false
        self.phoneTextField.translatesAutoresizingMaskIntoConstraints = false
        self.passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        self.passwordConfirmTextField.translatesAutoresizingMaskIntoConstraints = false
        
        self.emailTextField.removeConstraints(self.emailTextField.constraints)
        self.emailConfirmationTextField.removeConstraints(self.emailConfirmationTextField.constraints)
        self.phoneTextField.removeConstraints(self.phoneTextField.constraints)
        self.passwordTextField.removeConstraints(self.passwordTextField.constraints)
        self.passwordConfirmTextField.removeConstraints(self.passwordConfirmTextField.constraints)
        
        self.emailTextField.widthAnchor.constraintEqualToAnchor(self.view.widthAnchor, multiplier: 0.75).active = true
        self.emailConfirmationTextField.widthAnchor.constraintEqualToAnchor(self.view.widthAnchor, multiplier: 0.75).active = true
        self.phoneTextField.widthAnchor.constraintEqualToAnchor(self.view.widthAnchor, multiplier: 0.75).active = true
        self.passwordTextField.widthAnchor.constraintEqualToAnchor(self.view.widthAnchor, multiplier: 0.75).active = true
        self.passwordConfirmTextField.widthAnchor.constraintEqualToAnchor(self.view.widthAnchor, multiplier: 0.75).active = true
        
        self.emailTextField.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor).active = true
        self.emailConfirmationTextField.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor).active = true
        self.phoneTextField.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor).active = true
        self.passwordTextField.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor).active = true
        self.passwordConfirmTextField.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor).active = true
        
        self.emailTextField.topAnchor.constraintEqualToAnchor(self.view.topAnchor, constant: 30.0).active = true
        self.emailConfirmationTextField.topAnchor.constraintEqualToAnchor(self.emailTextField.bottomAnchor, constant: 10.0).active = true
        self.phoneTextField.topAnchor.constraintEqualToAnchor(self.emailConfirmationTextField.bottomAnchor, constant: 10.0).active = true
        self.passwordTextField.topAnchor.constraintEqualToAnchor(self.phoneTextField.bottomAnchor, constant: 10.0).active = true
        self.passwordConfirmTextField.topAnchor.constraintEqualToAnchor(self.passwordTextField.bottomAnchor, constant: 10.0).active = true
        
        self.submitButton.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor).active = true
        self.submitButton.topAnchor.constraintEqualToAnchor(self.passwordConfirmTextField.bottomAnchor, constant: 50.0).active = true
    }
    
    
    
}