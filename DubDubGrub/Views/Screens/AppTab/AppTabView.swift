//
//  AppTabView.swift
//  DubDubGrub
//
//  Created by Pablo Cornejo on 5/23/21.
//

import SwiftUI

struct AppTabView: View {
    
    @StateObject private var viewModel = AppTabViewModel()
    
    var body: some View {
        TabView {
            LocationMapView()
                .tabItem { Label("Map", systemImage: "map") }
            
            LocationListView()
                .tabItem { Label("Locations", systemImage: "building") }
            
            NavigationView { ProfileView() }
                .tabItem { Label("Profile", systemImage: "person") }
        }
        .onAppear {
            CloudKitManager.shared.getUserRecord()
            viewModel.runStartupChecks()
        }
        .accentColor(.brandPrimary)
        .sheet(isPresented: $viewModel.isShowingOnboardingView, onDismiss: viewModel.checkIfLocationServicesIsEnabled) {
            OnboardingView(isShowingOnboardingView: $viewModel.isShowingOnboardingView)
        }
    }
}

struct AppTabView_Previews: PreviewProvider {
    static var previews: some View {
        AppTabView()
    }
}
