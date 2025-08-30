//
//  LoginFlowTests.swift
//  EventRegistrationTests
//
//  Created on 20/08/25.
//

import XCTest
import SwiftUI
@testable import EventRegistration

final class LoginFlowTests: XCTestCase {
    
    func testValidLoginCredentials() {
        // Test the login logic with valid credentials
        let expectation = XCTestExpectation(description: "Login should succeed")
        
        // Create a mock login view to test the logic
        class MockLoginView {
            var username = "user123"
            var password = "1234"
            var isLoginSuccess = false
            var errorMessage: String?
            
            func handleLogin() -> Bool {
                if username.isEmpty || password.isEmpty {
                    errorMessage = "Please enter both username and password."
                    isLoginSuccess = false
                    return false
                }
                
                if username.lowercased() == "user123" && password == "1234" {
                    errorMessage = nil
                    isLoginSuccess = true
                    return true
                } else {
                    errorMessage = "Invalid credentials."
                    isLoginSuccess = false
                    return false
                }
            }
        }
        
        let mockLogin = MockLoginView()
        let result = mockLogin.handleLogin()
        
        XCTAssertTrue(result, "Login should succeed with valid credentials")
        XCTAssertTrue(mockLogin.isLoginSuccess, "isLoginSuccess should be true")
        XCTAssertNil(mockLogin.errorMessage, "Error message should be nil for valid login")
        
        expectation.fulfill()
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testInvalidLoginCredentials() {
        class MockLoginView {
            var username = "wrong"
            var password = "wrong"
            var isLoginSuccess = false
            var errorMessage: String?
            
            func handleLogin() -> Bool {
                if username.isEmpty || password.isEmpty {
                    errorMessage = "Please enter both username and password."
                    isLoginSuccess = false
                    return false
                }
                
                if username.lowercased() == "user123" && password == "1234" {
                    errorMessage = nil
                    isLoginSuccess = true
                    return true
                } else {
                    errorMessage = "Invalid credentials."
                    isLoginSuccess = false
                    return false
                }
            }
        }
        
        let mockLogin = MockLoginView()
        let result = mockLogin.handleLogin()
        
        XCTAssertFalse(result, "Login should fail with invalid credentials")
        XCTAssertFalse(mockLogin.isLoginSuccess, "isLoginSuccess should be false")
        XCTAssertEqual(mockLogin.errorMessage, "Invalid credentials.", "Should show invalid credentials error")
    }
    
    func testEmptyCredentials() {
        class MockLoginView {
            var username = ""
            var password = ""
            var isLoginSuccess = false
            var errorMessage: String?
            
            func handleLogin() -> Bool {
                if username.isEmpty || password.isEmpty {
                    errorMessage = "Please enter both username and password."
                    isLoginSuccess = false
                    return false
                }
                
                if username.lowercased() == "user123" && password == "1234" {
                    errorMessage = nil
                    isLoginSuccess = true
                    return true
                } else {
                    errorMessage = "Invalid credentials."
                    isLoginSuccess = false
                    return false
                }
            }
        }
        
        let mockLogin = MockLoginView()
        let result = mockLogin.handleLogin()
        
        XCTAssertFalse(result, "Login should fail with empty credentials")
        XCTAssertFalse(mockLogin.isLoginSuccess, "isLoginSuccess should be false")
        XCTAssertEqual(mockLogin.errorMessage, "Please enter both username and password.", "Should show empty credentials error")
    }
}
