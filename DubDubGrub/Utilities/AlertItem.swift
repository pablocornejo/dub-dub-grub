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
}
