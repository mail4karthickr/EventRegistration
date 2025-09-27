//
//  LoginAccessibilityId.swift
//  Login
//
//  Created by Karthick Ramasamy on 27/09/25.
//

/// Accessibility identifiers for the login screen fields, buttons, and messages.
enum LoginAccessibilityIds: String {
    /// The username text field where the user enters their username.
    /// Use this for finding and interacting with the username field in UI tests and accessibility.
    case username = "username"
    
    /// The password text field where the user enters their password securely.
    /// Use this for finding and interacting with the password field in UI tests and accessibility.
    case password = "password"
    
    /// The login button that triggers authentication when tapped.
    /// Use this to find and tap the login button in UI testing and accessibility workflows.
    case login = "login"
    
    /// The success message label shown after a successful login.
    /// Use this to verify successful login actions in automated tests and accessibility tools.
    case successMessage = "success_message"
    
    /// The error message label shown when login fails or input is invalid.
    /// Use this to verify error handling in UI tests and accessibility scenarios.
    case errorMessage = "error_message_field"
    
    /// A human-readable description about the field, for use in documentation or UI automation tools.
    var description: String {
        switch self {
        case .username:
            return "The text field for user to enter their username."
        case .password:
            return "The secure text field for user to enter their password."
        case .login:
            return "The button that submits the login form."
        case .successMessage:
            return "The label displaying a successful login message."
        case .errorMessage:
            return "The label displaying errors when login fails or input is invalid."
        }
    }
}
