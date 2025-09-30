import XCTest

// Test-only mirror of accessibility identifiers to avoid linking the app module from UI tests.
// Keep these strings in sync with the app's LoginAccessibilityIds.
private struct LoginAccessibilityIds {
    struct Login {
        struct AuthenticationId { let id: String }
        struct Authentication {
            static let username = AuthenticationId(id: "login.authentication.username")
            static let password = AuthenticationId(id: "login.authentication.password")
            static let loginButton = AuthenticationId(id: "login.authentication.loginButton")
            static let successMessage = AuthenticationId(id: "login.authentication.successMessage")
            static let errorMessage = AuthenticationId(id: "login.authentication.errorMessage")
        }
    }
}

class LoginTests: XCTestCase {

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        let app = XCUIApplication()
        app.launch()
    }

    func test_LoginButtonDisabled_WhenUsernameAndPasswordAreEmpty() {
        let app = XCUIApplication()
        _ = app.wait(for: .runningForeground, timeout: 2)
        // When both Username and Password fields are empty → the Login button must remain disabled.
        let loginButton = app.buttons[LoginAccessibilityIds.Login.Authentication.loginButton.id]
        XCTAssertFalse(loginButton.isEnabled, "Login button should be disabled when both fields are empty.")
    }

    func test_LoginButtonDisabled_WhenUsernameIsEnteredAndPasswordIsMissing() {
        let app = XCUIApplication()
        _ = app.wait(for: .runningForeground, timeout: 2)
        // When Username is entered but Password is missing → the Login button must remain disabled.
        let usernameField = app.textFields[LoginAccessibilityIds.Login.Authentication.username.id]
        usernameField.tap()
        usernameField.typeText("user123")

        let loginButton = app.buttons[LoginAccessibilityIds.Login.Authentication.loginButton.id]
        XCTAssertFalse(loginButton.isEnabled, "Login button should be disabled when Username is entered and Password is missing.")
    }

    func test_LoginButtonDisabled_WhenPasswordIsEnteredAndUsernameIsMissing() {
        let app = XCUIApplication()
        _ = app.wait(for: .runningForeground, timeout: 2)
        // When Password is entered but Username is missing → the Login button must remain disabled.
        let passwordField = app.secureTextFields[LoginAccessibilityIds.Login.Authentication.password.id]
        passwordField.tap()
        passwordField.typeText("1234")

        let loginButton = app.buttons[LoginAccessibilityIds.Login.Authentication.loginButton.id]
        XCTAssertFalse(loginButton.isEnabled, "Login button should be disabled when Password is entered and Username is missing.")
    }

    func test_LoginButtonEnabled_WhenBothFieldsAreFilled() {
        let app = XCUIApplication()
        _ = app.wait(for: .runningForeground, timeout: 2)
        // When both Username and Password fields are filled → the Login button becomes enabled.
        let usernameField = app.textFields[LoginAccessibilityIds.Login.Authentication.username.id]
        usernameField.tap()
        usernameField.typeText("user123")

        let passwordField = app.secureTextFields[LoginAccessibilityIds.Login.Authentication.password.id]
        passwordField.tap()
        passwordField.typeText("1234")

        let loginButton = app.buttons[LoginAccessibilityIds.Login.Authentication.loginButton.id]
        XCTAssertTrue(loginButton.isEnabled, "Login button should be enabled when both fields are filled.")
    }

    func test_SuccessfulLogin() {
        let app = XCUIApplication()
        _ = app.wait(for: .runningForeground, timeout: 2)
        // Given the user enters Username = user123 and Password = 1234, when they tap the Login button, then the system must display the message: “Login is successful”.
        let usernameField = app.textFields[LoginAccessibilityIds.Login.Authentication.username.id]
        usernameField.tap()
        usernameField.typeText("user123")

        let passwordField = app.secureTextFields[LoginAccessibilityIds.Login.Authentication.password.id]
        passwordField.tap()
        passwordField.typeText("1234")

        app.buttons[LoginAccessibilityIds.Login.Authentication.loginButton.id].tap()

        let successMessage = app.staticTexts[LoginAccessibilityIds.Login.Authentication.successMessage.id]
        XCTAssertTrue(successMessage.exists, "Success message should be displayed after successful login.")
    }

    func test_InvalidLogin() {
        let app = XCUIApplication()
        _ = app.wait(for: .runningForeground, timeout: 2)
        // Given the user enters any incorrect Username or Password, when they tap the Login button, then the system must display the message: “Invalid credentials.”
        let usernameField = app.textFields[LoginAccessibilityIds.Login.Authentication.username.id]
        usernameField.tap()
        usernameField.typeText("wrongUser")

        let passwordField = app.secureTextFields[LoginAccessibilityIds.Login.Authentication.password.id]
        passwordField.tap()
        passwordField.typeText("wrongPass")

        app.buttons[LoginAccessibilityIds.Login.Authentication.loginButton.id].tap()

        let errorMessage = app.staticTexts[LoginAccessibilityIds.Login.Authentication.errorMessage.id]
        XCTAssertTrue(errorMessage.exists, "Error message should be displayed after invalid login.")
    }
}
