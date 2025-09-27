//
//  EventsListingAccessibilityId.swift
//  Login
//
//  Created by Karthick Ramasamy on 27/09/25.
//

/// Accessibility identifiers for the events listing screen fields, buttons, and messages.
enum EventsListingAccessibilityIds: String {
    /// The main list displaying all available events.
    /// Use this to access the events list in UI tests and accessibility.
    case eventsList = "events_list"
    
    /// The button in each event row that reveals more information about the event.
    /// Use this to tap the 'More' button in UI automation.
    case moreButton = "more_button"
    
    /// The button used to register or unregister from an event.
    /// Use this to automate event registration or unregistration actions.
    case registerButton = "register_button"
    
    /// The label displaying a confirmation message after registration.
    /// Use this to verify successful registration actions in UI tests.
    case registrationMessage = "registration_message"
    
    /// A human-readable description about this field, for use in documentation or UI automation tools.
    var description: String {
        switch self {
        case .eventsList:
            return "The list that displays all available events for the user."
        case .moreButton:
            return "A button in each event row to show more details about the selected event."
        case .registerButton:
            return "The button that allows the user to register or unregister for an event."
        case .registrationMessage:
            return "A label that displays a confirmation message after successfully registering for an event."
        }
    }
}
