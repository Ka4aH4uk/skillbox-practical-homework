import XCTest
@testable import SkillboxTesting

final class LoginServiceTests: XCTestCase {
    var loginService: LoginService!
    
    override func setUp() {
        loginService = LoginService()
    }
    
    override func tearDown() {
        loginService = nil
    }
    
    /// {unit-of-work} _ {scenario} _ {expected-results-or-behaviour}
    func test_checkCredentials_ValidLogin_CorrectResult() {
        // Given
        let validLogin = "test@google.com"
        let validPassword = "Qwerty12345"
        let validPassword2 = "Qwerty12345"
        
        // When
        let result = loginService.checkCredentials(login: validLogin, password: validPassword, password2: validPassword2)
        
        // Then
        XCTAssertEqual(result, .correct)
    }

    func test_checkCredentials_InvalidLogin_InvalidLoginResult() {
        // Given
        let invalidLogin = "invalidemail"
        let validPassword = "Qwerty12345"
        let validPassword2 = "Qwerty12345"
        
        // When
        let result = loginService.checkCredentials(login: invalidLogin, password: validPassword, password2: validPassword2)
        
        // Then
        XCTAssertEqual(result, .invalidLogin)
    }
}
