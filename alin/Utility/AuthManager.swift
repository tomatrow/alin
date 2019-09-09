//
//  AuthManager.swift
//  alin
//
//  Created by AJ Caldwell on 9/9/19.
//  Copyright © 2019 LST. All rights reserved.
//

import Foundation
import FirebaseAuth
import UIKit

enum AuthManagerError: Error {
    case signIn(Error)
    case signUp(Error)
    case validation
    
    var title: String {
        let text: String
        switch self {
        case .signIn:
            text = "Sign in"
        case .signUp:
            text = "Sign up"
        case .validation:
            text = "Validation"
        }
        return "\(text) Error"
    }
    
    var localizedDescription: String {
        switch self {
        case .signIn(let error):
            return error.localizedDescription
        case .signUp(let error):
            return error.localizedDescription
        case .validation:
            return "Both fields must be filled out"
        }
    }
}

protocol AuthManager {
    var emailField: UITextField! { get }
    var passwordField: UITextField! { get }

    var email: String? { get }
    var password: String? { get }
    var info: (email: String, password: String)? { get }
    
    func signIn() throws 
    func signUp() throws 
    
    func handle(error: AuthManagerError)
}

extension AuthManager {
    
    var email: String? {
        guard let email = emailField.text, email.count > 0 else { return nil }
        return email 
    }
    
    var password: String? {
        guard let password = passwordField.text, password.count > 0 else { return nil }
        return password
    }
    
    var info: (email: String, password: String)? {
        guard let email = email, let password = password else { return nil }
        return (email, password)
    } 
    
    func signUp() throws {
        guard let info = info else { throw AuthManagerError.validation }
        Auth.auth().createUser(withEmail: info.email, password: info.password) { user, error in
            guard user != nil, error == nil else {
                self.handle(error: .signUp(error!))
                return 
            }
            try? self.signIn()
        }
    }
    
    func signIn() throws {
        guard let info = info else { throw AuthManagerError.validation }
        Auth.auth().signIn(withEmail: info.email, password: info.password) { (user, error) in
            guard let error = error, user == nil else { return }
            self.handle(error: .signIn(error))
        }
    }
}
