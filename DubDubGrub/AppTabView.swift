//
//  AppTabView.swift
//  DubDubGrub
//
//  Created by Pablo Cornejo on 5/23/21.
//

import SwiftUI

struct AppTabView: View {
    var body: some View {
        TabView {
            LocationMapView()
                .tabItem { Label("Map", systemImage: "map") }
            
            LocationListView()
                .tabItem { Label("Locations", systemImage: "building") }
            
            NavigationView {
                ProfileView()
            }
            .tabItem { Label("Profile", systemImage: "person") }
        }
        .accentColor(.brandPrimary)
    }
}

struct AppTabView_Previews: PreviewProvider {
    static var previews: some View {
        AppTabView()
    }
}
