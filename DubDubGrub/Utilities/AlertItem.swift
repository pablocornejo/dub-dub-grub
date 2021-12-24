//
//  AlertItem.swift
//  DubDubGrub
//
//  Created by Pablo Cornejo on 6/1/21.
//

import SwiftUI

struct AlertItem: Identifiable {
    let id: UUID = .init()
    let title: Text
    let message: Text
    let dismissButton: Alert.Button
    
    func convertToAlert() -> Alert {
        Alert(title: title, message: message, dismissButton: dismissButton)
    }
}

enum AlertContext {
    // MARK: MapView Errors
    static let unableToGetLocations = AlertItem(title: Text("Locations Error"),
                                                message: Text("Unable to retrieve locations at this time.\nPlease try again"),
                                                dismissButton: .default(Text("OK")))
    
    static let locationRestricted = AlertItem(title: Text("Location Restricted"),
                                              message: Text("Your location is restricted. This may be due to parental controls."),
                                              dismissButton: .default(Text("OK")))
    
    static let locationDenied = AlertItem(title: Text("Location Denied"),
                                          message: Text("Dub Dub Grub does not have permission to access your location. To change that go to your phone's Settings > Dub Dub Grub > Location"),
                                          dismissButton: .default(Text("OK")))
    
    static let locationDisabled = AlertItem(title: Text("Location Services Disabled"),
                                            message: Text("Your phone's location services are disabled. To change that go to your phone's Settings > Privacy > Location Services"),
                                            dismissButton: .default(Text("OK")))
    // MARK: ProfileView Errors
    static let invalidProfile = AlertItem(title: Text("Invalid Profile"),
                                          message: Text("All fields are required as well as a profile photo. Your bio must be <100 characters.\nPlease try again."),
                                          dismissButton: .default(Text("OK")))
}
