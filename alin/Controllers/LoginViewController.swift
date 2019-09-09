//
//  LoginViewController.swift
//  alin
//
//  Created by AJ Caldwell on 9/7/19.
//  Copyright © 2019 LST. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

    @IBAction func loginButtonTapped(_ sender: Any) {
        do {
            try signIn() 
        } catch (let error) {
            handle(error: error as! AuthManagerError)
        }
    }
    @IBAction func signUpButtonTapped(_ sender: Any) {
        do {
            try signUp() 
        } catch (let error) {
            handle(error: error as! AuthManagerError)
        }
    }
    
    func configure() {
        emailField.delegate = self 
        passwordField.delegate = self
        Auth.auth().addStateDidChangeListener() { auth, user in
            
        }
    }
}

extension LoginViewController: AuthManager {
    func handle(error: AuthManagerError) {
        showPrompt(title: error.title, message: error.localizedDescription)
    }
}

extension LoginViewController {
    func showPrompt(title: String, message: String) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true, completion: nil)
    }
}

extension LoginViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case emailField:
            passwordField.becomeFirstResponder()
        case passwordField:
            passwordField.resignFirstResponder()
        default:
            print("Default textFieldShouldReturn")
        }
        return true
    }
}


