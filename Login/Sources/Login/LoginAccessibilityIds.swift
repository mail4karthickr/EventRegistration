//
//  LoginAccessibilityIds.swift
//  Login
//
//  Created by Karthick Ramasamy on 27/09/25.
//

/// Accessibility identifiers for the Login feature.
///
/// Why this exists:
/// - Centralizes all accessibility identifiers used by the Login UI so they are stable and discoverable.
/// - Keeps identifiers consistent and non-localized for use in UI tests and assistive technologies.
/// - Uses a simple naming convention: "<screen>.<component>.<element>".
///
/// Naming convention:
/// - screen: "login"
/// - component: "authentication"
/// - element: specific control or message name (e.g., "username", "password", "loginButton").
///
/// Usage:
/// ```swift
/// usernameTextField.accessibilityIdentifier = LoginAccessibilityIds.Login.Authentication.username.rawValue
/// loginButton.accessibilityIdentifier = LoginAccessibilityIds.Login.Authentication.loginButton.rawValue
/// // Or, using the convenience property:
/// errorLabel.accessibilityIdentifier = LoginAccessibilityIds.Login.Authentication.errorMessage.id
/// ```
///
/// Notes for future contributors and LLMs:
/// - Do NOT change existing raw string values; UI tests and analytics may depend on them.
/// - When adding a new element, follow the established naming pattern and include a clear doc comment.
public struct LoginAccessibilityIds {

    /// Namespace for identifiers used on the Login screen.
    public enum Login {
        /// Accessibility identifiers for the Authentication component on the Login screen.
        public enum Authentication: String {
            /// Username text field where the user enters their username or email.
            case username = "login.authentication.username"
            /// Password secure text field where the user enters their password.
            case password = "login.authentication.password"
            /// Primary call-to-action button that attempts to authenticate the user.
            case loginButton = "login.authentication.loginButton"
            /// Label shown when authentication succeeds.
            case successMessage = "login.authentication.successMessage"
            /// Label or inline text shown when authentication fails.
            case errorMessage = "login.authentication.errorMessage"

            /// Fully qualified accessibility identifier string (same as `rawValue`).
            public var id: String { rawValue }
        }
    }
}
