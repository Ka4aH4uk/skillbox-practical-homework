import XCTest

final class RegistrationScreenUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDown() {
        app.terminate()
    }

    // Логин является валидным имейлом
    func test_InvalidEmail_ShowsErrorMessage() throws {
        /// Given
        let loginTextField = app.textFields["loginTextField"]
        let registerButton = app.buttons["buttonRegister"]
        let label = app.staticTexts["messageLabel"]

        /// When
        loginTextField.tap()
        loginTextField.typeText("invalidemail")
        
        registerButton.tap()
        
        XCTAssertTrue(label.waitForExistence(timeout: 2))

        /// Then
        XCTAssertEqual(loginTextField.value as? String, "invalidemail")
        XCTAssertEqual(label.label, "Enter correct email")
    }

    // Пароль содержит от шести символов
    func test_ShortPassword_ShowsErrorMessage() throws {
        /// Given
        let loginTextField = app.textFields["loginTextField"]
        let passwordTextField = app.textFields["passwordTextField"]
        let registerButton = app.buttons["buttonRegister"]
        let label = app.staticTexts["messageLabel"]

        /// When
        loginTextField.tap()
        loginTextField.typeText("1@gmail.com")
        
        passwordTextField.tap()
        passwordTextField.typeText("pass")
        
        registerButton.tap()
        
        XCTAssertTrue(label.waitForExistence(timeout: 2))

        /// Then
        XCTAssertEqual(passwordTextField.value as? String, "pass")
        XCTAssertEqual(label.label, "Password should be more than 6 symbols")
    }

    // Пароль содержит как минимум одну заглавную букву
    func test_PasswordWithoutUppercase_ShowsErrorMessage() throws {
        /// Given
        let loginTextField = app.textFields["loginTextField"]
        let passwordTextField = app.textFields["passwordTextField"]
        let registerButton = app.buttons["buttonRegister"]
        let label = app.staticTexts["messageLabel"]

        /// When
        loginTextField.tap()
        loginTextField.typeText("1@gmail.com")
        
        passwordTextField.tap()
        passwordTextField.typeText("password123")
        
        registerButton.tap()
        
        XCTAssertTrue(label.waitForExistence(timeout: 2))

        /// Then
        XCTAssertEqual(passwordTextField.value as? String, "password123")
        XCTAssertEqual(label.label, "Password should have at least one upper letter")
    }

    // Пароль содержит как минимум одну прописную букву
    func test_PasswordWithoutLowercase_ShowsErrorMessage() throws {
        /// Given
        let loginTextField = app.textFields["loginTextField"]
        let passwordTextField = app.textFields["passwordTextField"]
        let registerButton = app.buttons["buttonRegister"]
        let label = app.staticTexts["messageLabel"]

        /// When
        loginTextField.tap()
        loginTextField.typeText("1@gmail.com")
        
        passwordTextField.tap()
        passwordTextField.typeText("PASSWORD123")
        
        registerButton.tap()
        
        XCTAssertTrue(label.waitForExistence(timeout: 2))

        /// Then
        XCTAssertEqual(passwordTextField.value as? String, "PASSWORD123")
        XCTAssertEqual(label.label, "Password should have at least one lower letter")
    }

    // Пароль содержит как минимум одну цифру
    func test_PasswordWithoutDigit_ShowsErrorMessage() throws {
        /// Given
        let loginTextField = app.textFields["loginTextField"]
        let passwordTextField = app.textFields["passwordTextField"]
        let registerButton = app.buttons["buttonRegister"]
        let label = app.staticTexts["messageLabel"]

        /// When
        loginTextField.tap()
        loginTextField.typeText("1@gmail.com")
        
        passwordTextField.tap()
        passwordTextField.typeText("Password")
        
        registerButton.tap()
        
        XCTAssertTrue(label.waitForExistence(timeout: 2))

        /// Then
        XCTAssertEqual(passwordTextField.value as? String, "Password")
        XCTAssertEqual(label.label, "Password should have at least one digit")
    }

    // Пароль не содержит знаков пунктуации и пробелов
    func test_PasswordWithPunctuation_ShowsErrorMessage() throws {
        /// Given
        let loginTextField = app.textFields["loginTextField"]
        let passwordTextField = app.textFields["passwordTextField"]
        let registerButton = app.buttons["buttonRegister"]
        let label = app.staticTexts["messageLabel"]

        /// When
        loginTextField.tap()
        loginTextField.typeText("1@gmail.com")
        
        passwordTextField.tap()
        passwordTextField.typeText("Password!123")
        
        registerButton.tap()
        
        XCTAssertTrue(label.waitForExistence(timeout: 2))

        /// Then
        XCTAssertEqual(passwordTextField.value as? String, "Password!123")
        XCTAssertEqual(label.label, "Password contains illegal characters")
    }

    // Пароли совпадают
    func test_ConfirmPassword_DoesNotMatchPassword_ShowsErrorMessage() throws {
        /// Given
        let loginTextField = app.textFields["loginTextField"]
        let passwordTextField = app.textFields["passwordTextField"]
        let confirmPasswordTextField = app.textFields["confirmPasswordTextField"]
        let registerButton = app.buttons["buttonRegister"]
        let label = app.staticTexts["messageLabel"]

        /// When
        loginTextField.tap()
        loginTextField.typeText("1@gmail.com")
        
        passwordTextField.tap()
        passwordTextField.typeText("Password123")

        confirmPasswordTextField.tap()
        confirmPasswordTextField.typeText("Password")
        
        registerButton.tap()
        
        XCTAssertTrue(label.waitForExistence(timeout: 2))

        /// Then
        XCTAssertEqual(confirmPasswordTextField.value as? String, "Password")
        XCTAssertEqual(label.label, "Passwords are not identical")
    }

    // Регистрация прошла успешно
    func test_RegisterValidCredentials_SuccessfulRegistration() {
        /// Given
        let loginTextField = app.textFields["loginTextField"]
        let passwordTextField = app.textFields["passwordTextField"]
        let confirmPasswordTextField = app.textFields["confirmPasswordTextField"]
        let registerButton = app.buttons["buttonRegister"]
        let label = app.staticTexts["messageLabel"]

        /// When
        loginTextField.tap()
        loginTextField.typeText("1@gmail.com")

        passwordTextField.tap()
        passwordTextField.typeText("Password123")

        confirmPasswordTextField.tap()
        confirmPasswordTextField.typeText("Password123")

        registerButton.tap()
        
        XCTAssertTrue(label.waitForExistence(timeout: 2))

        /// Then
        XCTAssertTrue(app.staticTexts["messageLabel"].exists)
        XCTAssertEqual(label.label, "You are successfully registered!")
    }
}
