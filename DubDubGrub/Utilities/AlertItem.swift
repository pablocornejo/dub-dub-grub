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
    
    static let noUserRecord = AlertItem(title: Text("No User Record"),
                                        message: Text("You must log into iCloud on your phone in order to utilize Dub Dub Grub profile. Please log in on your phone's settings screen."),
                                        dismissButton: .default(Text("OK")))
    
    static let createProfileSuccess = AlertItem(title: Text("Profile Created Successfully!"),
                                                message: Text("Your profile has successfully been created."),
                                                dismissButton: .default(Text("OK")))
    
    static let createProfileFailure = AlertItem(title: Text("Failed to Create Profile"),
                                                message: Text("We were unable to create your profile at this time.\nPlease try again later or contact customer support if this persists."),
                                                dismissButton: .default(Text("OK")))
    
    static let unableToGetProfile = AlertItem(title: Text("Unable To Retrieve Profile"),
                                              message: Text("We were unable to retrieve your profile at this time.\nPlease check your internet connection and try again later or contact customer support if this persists."),
                                              dismissButton: .default(Text("OK")))
    
    static let updateProfileSuccess = AlertItem(title: Text("Profile Updated Successfully!"),
                                                message: Text("Your profile was updated successfully."),
                                                dismissButton: .default(Text("OK")))
    
    static let updateProfileFailure = AlertItem(title: Text("Profile Updated Failed"),
                                                message: Text("We were unable to create your profile at this time.\nPlease try again later."),
                                                dismissButton: .default(Text("OK")))
    
    // MARK: LocationDetailView Errors
    static let invalidPhoneNumber = AlertItem(title: Text("Invalid Phone Number"),
                                              message: Text("The phone number for the location is invalid. Please look up the phone number yourself."),
                                              dismissButton: .default(Text("OK")))
}
