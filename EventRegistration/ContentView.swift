//
//  ContentView.swift
//  EventRegistration
//
//  Created by Karthick Ramasamy on 13/08/25.
//

import SwiftUI
import Login

struct Event: Identifiable {
    let id = UUID()
    var title: String
    var description: String
    var date: Date
    var imageURL: URL?
}

struct ContentView: View {
    @State private var isLoggedIn: Bool = false
    
    var body: some View {
        ZStack {
            Color(.systemGroupedBackground)
                .ignoresSafeArea()
            if isLoggedIn {
                EventListView(onBack: { isLoggedIn = false })
            } else {
                CustomLoginView(onLoginSuccess: { isLoggedIn = true })
            }
        }
    }
}

// Custom Login View that can communicate with ContentView
struct CustomLoginView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var errorMessage: String?
    @State private var isLoginSuccess: Bool = false
    
    let onLoginSuccess: () -> Void
    
    var body: some View {
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
                    .accessibilityIdentifier(LoginAccessibilityIds.Login.Authentication.username.id)
                
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
                    .accessibilityIdentifier(LoginAccessibilityIds.Login.Authentication.password.id)
                
                if isLoginSuccess {
                    Text("Login successful! Redirecting...")
                        .foregroundColor(.green)
                        .font(.subheadline)
                        .multilineTextAlignment(.center)
                        .accessibilityIdentifier(LoginAccessibilityIds.Login.Authentication.successMessage.id)
                }
                
                // Error Message
                if let errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .font(.subheadline)
                        .multilineTextAlignment(.center)
                        .accessibilityIdentifier(LoginAccessibilityIds.Login.Authentication.errorMessage.id)
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
                .accessibilityIdentifier(LoginAccessibilityIds.Login.Authentication.loginButton.id)
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
            // Delay navigation to show success message
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                onLoginSuccess()
            }
        } else {
            errorMessage = "Invalid credentials."
            isLoginSuccess = false
        }
    }
}

// Keep the preview as is
#Preview {
    ContentView()
}

struct EventListView: View {
    @State private var events = [
        Event(title: "SwiftUI Workshop", description: "Learn the latest in SwiftUI.", date: Date().addingTimeInterval(60*60*24), imageURL: URL(string: "https://images.pexels.com/photos/1181675/pexels-photo-1181675.jpeg")),
        Event(title: "iOS Conference", description: "Meet professionals and enthusiasts.", date: Date().addingTimeInterval(60*60*48), imageURL: URL(string: "https://images.pexels.com/photos/3184298/pexels-photo-3184298.jpeg")),
        Event(title: "Tech Meetup", description: "Networking and more.", date: Date().addingTimeInterval(60*60*72), imageURL: URL(string: "https://images.pexels.com/photos/1707828/pexels-photo-1707828.jpeg")),
        Event(title: "Networking Night", description: "Make valuable connections.", date: Date().addingTimeInterval(60*60*96), imageURL: URL(string: "https://images.pexels.com/photos/1181406/pexels-photo-1181406.jpeg")),
        Event(title: "App Launch", description: "Celebrate the new release.", date: Date().addingTimeInterval(60*60*120), imageURL: URL(string: "https://images.pexels.com/photos/265087/pexels-photo-265087.jpeg")),
    ]
    
    @State private var selectedEvent: Event? = nil
    @State private var registeredEventIDs: Set<UUID> = []
    @State private var showRegistrationMessage: Bool = false
    
    let onBack: () -> Void
    
    var body: some View {
        NavigationView {
            List(events) { event in
                EventRow(event: event, onMore: { selectedEvent = event })
            }
            .accessibilityIdentifier("events_list")
            .navigationTitle("Events")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: onBack) {
                        Image(systemName: "arrow.backward")
                    }
                }
            }
            .sheet(item: $selectedEvent) { event in
                VStack(spacing: 24) {
                    Text(event.title)
                        .font(.largeTitle)
                        .bold()
                        .multilineTextAlignment(.center)
                    
                    if !event.description.isEmpty {
                        Text(event.description)
                            .font(.body)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.secondary)
                    }
                    
                    Text(event.date.formatted(date: .abbreviated, time: .shortened))
                        .font(.headline)
                        .foregroundColor(.secondary)
                    
                    Button(action: {
                        if registeredEventIDs.contains(event.id) {
                            registeredEventIDs.remove(event.id)
                        } else {
                            registeredEventIDs.insert(event.id)
                            showRegistrationMessage = true
                        }
                    }) {
                        Label(
                            registeredEventIDs.contains(event.id) ? "Unregister" : "Register",
                            systemImage: registeredEventIDs.contains(event.id) ? "xmark.circle" : "checkmark.circle"
                        )
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(registeredEventIDs.contains(event.id) ? Color.red.opacity(0.8) : Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .padding(.horizontal, 24)
                    }
                    
                    if showRegistrationMessage && registeredEventIDs.contains(event.id) {
                        Text("You have registered for this event!")
                            .foregroundColor(.green)
                            .font(.subheadline)
                            .padding(.top, 8)
                            .transition(.opacity)
                    }
                    
                    Spacer()
                }
                .padding()
                .presentationDetents([.medium, .large])
                .onDisappear {
                    showRegistrationMessage = false
                }
            }
        }
    }
}

struct EventRow: View {
    let event: Event
    let onMore: () -> Void
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            AsyncImage(url: event.imageURL) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(width: 64, height: 64)
                case .success(let image):
                    image.resizable()
                         .aspectRatio(contentMode: .fill)
                         .frame(width: 64, height: 64)
                         .clipped()
                         .cornerRadius(8)
                case .failure:
                    Image(systemName: "photo")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 64, height: 64)
                        .foregroundColor(.gray)
                @unknown default:
                    EmptyView()
                }
            }
            VStack(alignment: .leading, spacing: 6) {
                Text(event.title)
                    .font(.headline)
                Text(event.description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Text(event.date.formatted(date: .abbreviated, time: .shortened))
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            Spacer()
            Button("More", action: onMore)
                .buttonStyle(.bordered)
                .padding(.top, 8)
        }
        .padding(.vertical, 6)
    }
}

#Preview {
    EventListView(onBack: {})
}
