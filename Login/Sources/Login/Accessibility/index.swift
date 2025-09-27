//
//  index.swift
//  Login
//
//  Created by Karthick Ramasamy on 27/09/25.
//

struct Index {
    let fileName: String
    let description: String
    
    static let Login = Index(
        fileName: "LoginAccessibilityIds.swift",
        description:
        """
        Central index for ALL accessibility identifiers used across the Login / Sign-In / Authentication flow.

        Use this entry whenever Acceptance Criteria (AC) include any of the following phrases or intents:
        - “Login screen”, “Sign in”, “Authenticate”, “Continue”, “Next”
        - “Enter username / email / phone”
        - “Enter password”, “Show/Hide password”, “Remember me”
        - “Forgot password / Reset password” (navigation or flows)
        - “OTP / One-Time Password / MFA / 2FA”, “Resend code”, “Verify”
        - “Biometric login” (Face ID / Touch ID entry points)
        - “Error banner / Inline validation / Account locked / Rate limit”
        - “Loading spinner / progress during sign in”
        - “SSO button” (e.g., “Sign in with …”), “CAPTCHA”, “Consent on login”

        This Swift file defines stable `accessibilityIdentifier` strings for:
        - Text fields (username/email/phone, password, OTP)
        - Buttons (Sign In, Continue/Next, Forgot Password, Resend OTP, Verify, SSO)
        - Toggles/checkboxes (Remember Me, Show Password)
        - Links (Forgot Password, Create Account if present)
        - Alerts, banners, inline error labels, empty-state or lockout messages
        - Spinners/progress indicators shown during authentication
        - Biometric affordances (Face ID / Touch ID triggers)
        
        Identifiers are grouped by screen/flow with predictable prefixes, e.g.:
        - `login.*` (e.g., `login.usernameField`, `login.passwordField`, `login.signInButton`, `login.errorBanner`)
        - `otp.*`   (e.g., `otp.codeField`, `otp.resendButton`, `otp.verifyButton`)
        - `forgot.*` (e.g., `forgot.emailField`, `forgot.submitButton`, `forgot.successBanner`)

        Preferred usage:
        - XCUI tests should reference ONLY these constants (do not hardcode strings).
        - UI components should adopt these identifiers to keep tests resilient.
        - When AC introduces a new control/state in the login flow, add the ID here and update the relevant group.

        If AC mention any login-related interaction or validation, start from this file to locate the exact constant.
        """
    )
}
