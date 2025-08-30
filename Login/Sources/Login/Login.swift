import SwiftUI

public struct LoginView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var errorMessage: String?
    @State private var isLoginSuccess: Bool = false
    
    public init() {}
    
    public var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                Text("Sign In")
                    .font(.largeTitle).bold()
                    .padding(.top, 32)
                
                // Username Field
                TextField("Username", text: $username)
                    .textContentType(.username)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color(.systemGray6))
                            .shadow(color: .gray.opacity(0.2), radius: 3, x: 0, y: 2)
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color(.systemGray3), lineWidth: 1)
                    )
                    .accessibilityIdentifier("username")
                
                // Password Field
                SecureField("Password", text: $password)
                    .textContentType(.password)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color(.systemGray6))
                            .shadow(color: .gray.opacity(0.2), radius: 3, x: 0, y: 2)
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color(.systemGray3), lineWidth: 1)
                    )
                    .accessibilityIdentifier("password")
                
                if isLoginSuccess {
                    Text("Login is successful")
                        .foregroundColor(.green)
                        .font(.subheadline)
                        .multilineTextAlignment(.center)
                        .accessibilityIdentifier("success_message")
                }
                
                // Error Message
                if let errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .font(.subheadline)
                        .multilineTextAlignment(.center)
                        .accessibilityIdentifier("error_message_field")
                }
                
                // Login Button
                Button(action: handleLogin) {
                    Text("Login")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .shadow(color: .blue.opacity(0.20), radius: 4, x: 0, y: 2)
                }
                .accessibilityIdentifier("login")
                .padding(.top, 8)
                .disabled(username.isEmpty || password.isEmpty)
                
                Spacer()
            }
            .padding(.horizontal, 24)
        }
    }
    
    func handleLogin() {
        if username.isEmpty || password.isEmpty {
            errorMessage = "Please enter both username and password."
            isLoginSuccess = false
            return
        }
        // Demo login logic
        if username.lowercased() == "user123" && password == "1234" {
            errorMessage = nil
            isLoginSuccess = true
        } else {
            errorMessage = "Invalid credentials."
            isLoginSuccess = false
        }
    }
}

// Placeholder for events list destination
struct EventsListScreen: View {
    var body: some View {
        Text("Events List")
            .font(.title)
            .accessibilityIdentifier("events_list_screen")
    }
}

// SwiftUI preview
#Preview {
    LoginView()
}
