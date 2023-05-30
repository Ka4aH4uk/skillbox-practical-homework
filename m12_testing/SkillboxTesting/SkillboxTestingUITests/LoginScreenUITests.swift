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

    /// логин является валидным имейлом
    func test_ValidEmail_ValidatesSuccessfully() throws {
        // Given
        let loginTF = app.textFields["loginTF"]

        // When
        loginTF.tap()
        loginTF.typeText("1@gmail.com")

        // Then
        XCTAssertEqual(loginTF.value as? String, "1@gmail.com")
    }

    func test_InvalidEmail_ShowsErrorMessage() throws {
        // Given
        let loginTF = app.textFields["loginTF"]

        // When
        loginTF.tap()
        loginTF.typeText("invalidemail")

        // Then
        XCTAssertEqual(loginTF.value as? String, "invalidemail")
    }

    /// пароль содержит от шести символов
    func test_ValidPassword_ValidatesSuccessfully() throws {
        // Given
        let passwordTF = app.textFields["passwordTF"]

        // When
        passwordTF.tap()
        passwordTF.typeText("Password123")

        // Then
        XCTAssertEqual(passwordTF.value as? String, "Password123")
    }

    func test_ShortPassword_ShowsErrorMessage() throws {
        // Given
        let passwordTF = app.textFields["passwordTF"]

        // When
        passwordTF.tap()
        passwordTF.typeText("pass")

        // Then
        XCTAssertEqual(passwordTF.value as? String, "pass")
    }

    /// пароль содержит как минимум одну заглавную букву
    func test_PasswordWithoutUppercase_ShowsErrorMessage() throws {
        // Given
        let passwordTF = app.textFields["passwordTF"]

        // When
        passwordTF.tap()
        passwordTF.typeText("password123")

        // Then
        XCTAssertEqual(passwordTF.value as? String, "password123")
    }

    /// пароль содержит как минимум одну прописную букву
    func test_PasswordWithoutLowercase_ShowsErrorMessage() throws {
        // Given
        let passwordTF = app.textFields["passwordTF"]

        // When
        passwordTF.tap()
        passwordTF.typeText("PASSWORD123")

        // Then
        XCTAssertEqual(passwordTF.value as? String, "PASSWORD123")
    }

    /// пароль содержит как минимум одну цифру
    func test_PasswordWithoutDigit_ShowsErrorMessage() throws {
        // Given
        let passwordTF = app.textFields["passwordTF"]

        // When
        passwordTF.tap()
        passwordTF.typeText("Password")

        // Then
        XCTAssertEqual(passwordTF.value as? String, "Password")
    }

    /// пароль не содержит знаков пунктуации и пробелов
    func test_PasswordWithPunctuation_ShowsErrorMessage() throws {
        // Given
        let passwordTF = app.textFields["passwordTF"]

        // When
        passwordTF.tap()
        passwordTF.typeText("Password!123")

        // Then
        XCTAssertEqual(passwordTF.value as? String, "Password!123")
    }

    /// пароли совпадают
    func test_ConfirmPassword_MatchesPassword() throws {
        // Given
        let passwordTF = app.textFields["passwordTF"]
        let password2TF = app.textFields["2passwordTF"]

        // When
        passwordTF.tap()
        passwordTF.typeText("Password123")

        password2TF.tap()
        password2TF.typeText("Password123")

        // Then
        XCTAssertEqual(password2TF.value as? String, "Password123")
    }

    func test_ConfirmPassword_DoesNotMatchPassword_ShowsErrorMessage() throws {
        // Given
        let passwordTF = app.textFields["passwordTF"]
        let password2TF = app.textFields["2passwordTF"]

        // When
        passwordTF.tap()
        passwordTF.typeText("Password123")

        password2TF.tap()
        password2TF.typeText("Password")

        // Then
        XCTAssertEqual(password2TF.value as? String, "Password")
    }

    /// проверка всех систем
    func test_RegisterValidCredentials_SuccessfulRegistration() {
        // Given
        let loginTF = app.textFields["loginTF"]
        let passwordTF = app.textFields["passwordTF"]
        let password2TF = app.textFields["2passwordTF"]
        let registerButton = app.buttons["buttonRegister"]
        let label = app.staticTexts["messageLabel"] //

        // When
        loginTF.tap()
        loginTF.typeText("1@gmail.com")

        passwordTF.tap()
        passwordTF.typeText("Password123")

        password2TF.tap()
        password2TF.typeText("Password123")

        registerButton.tap()

        // Then
        XCTAssertTrue(app.staticTexts["messageLabel"].exists)
        XCTAssertEqual(label.label, "You are successfully registered!")
    }
}
