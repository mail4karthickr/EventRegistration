import XCTest

class LoginTests: XCTestCase {

    override func setUp() {
        super.setUp()
        let app = XCUIApplication()
        app.launch()
    }

    func test_LoginButtonDisabled_WhenUsernameAndPasswordAreEmpty() {
        // When both Username and Password fields are empty → the Login button must remain disabled.
        let loginButton = XCUIApplication().buttons["login"]
        XCTAssertFalse(loginButton.isEnabled, "Login button should be disabled when both fields are empty.")
    }

    func test_LoginButtonDisabled_WhenUsernameIsEnteredAndPasswordIsMissing() {
        // When Username is entered but Password is missing → the Login button must remain disabled.
        let usernameField = XCUIApplication().textFields["username"]
        usernameField.tap()
        usernameField.typeText("user123")

        let loginButton = XCUIApplication().buttons["login"]
        XCTAssertFalse(loginButton.isEnabled, "Login button should be disabled when Username is entered and Password is missing.")
    }

    func test_LoginButtonDisabled_WhenPasswordIsEnteredAndUsernameIsMissing() {
        // When Password is entered but Username is missing → the Login button must remain disabled.
        let passwordField = XCUIApplication().secureTextFields["password"]
        passwordField.tap()
        passwordField.typeText("1234")

        let loginButton = XCUIApplication().buttons["login"]
        XCTAssertFalse(loginButton.isEnabled, "Login button should be disabled when Password is entered and Username is missing.")
    }

    func test_LoginButtonEnabled_WhenBothFieldsAreFilled() {
        // When both Username and Password fields are filled → the Login button becomes enabled.
        let usernameField = XCUIApplication().textFields["username"]
        usernameField.tap()
        usernameField.typeText("user123")

        let passwordField = XCUIApplication().secureTextFields["password"]
        passwordField.tap()
        passwordField.typeText("1234")

        let loginButton = XCUIApplication().buttons["login"]
        XCTAssertTrue(loginButton.isEnabled, "Login button should be enabled when both fields are filled.")
    }

    func test_SuccessfulLogin() {
        // Given the user enters Username = user123 and Password = 1234, when they tap the Login button, then the system must display the message: “Login is successful”.
        let usernameField = XCUIApplication().textFields["username"]
        usernameField.tap()
        usernameField.typeText("user123")

        let passwordField = XCUIApplication().secureTextFields["password"]
        passwordField.tap()
        passwordField.typeText("1234")

        XCUIApplication().buttons["login"].tap()

        let successMessage = XCUIApplication().staticTexts["success_message"]
        XCTAssertTrue(successMessage.exists, "Success message should be displayed after successful login.")
    }

    func test_InvalidLogin() {
        // Given the user enters any incorrect Username or Password, when they tap the Login button, then the system must display the message: “Invalid credentials.”
        let usernameField = XCUIApplication().textFields["username"]
        usernameField.tap()
        usernameField.typeText("wrongUser")

        let passwordField = XCUIApplication().secureTextFields["password"]
        passwordField.tap()
        passwordField.typeText("wrongPass")

        XCUIApplication().buttons["login"].tap()

        let errorMessage = XCUIApplication().staticTexts["errormessage_field"]
        XCTAssertTrue(errorMessage.exists, "Error message should be displayed after invalid login.")
    }
}