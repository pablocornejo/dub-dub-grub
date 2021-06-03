//
//  DubDubGrubApp.swift
//  DubDubGrub
//
//  Created by Pablo Cornejo on 5/23/21.
//

import SwiftUI

@main
struct DubDubGrubApp: App {
    @StateObject var locationManager = LocationManager()
    
    var body: some Scene {
        WindowGroup {
            AppTabView()
                .environmentObject(locationManager)
        }
    }
}
