//
//  LocationMapView.swift
//  DubDubGrub
//
//  Created by Pablo Cornejo on 5/23/21.
//

import SwiftUI
import MapKit

struct LocationMapView: View {
    @EnvironmentObject private var locationManager: LocationManager
    @StateObject private var viewModel = LocationMapViewModel()
    
    var body: some View {
        ZStack(alignment: .top) {
            Map(coordinateRegion: $viewModel.region, showsUserLocation: true, annotationItems: locationManager.locations) { location in
                MapMarker(coordinate: location.location.coordinate, tint: .brandPrimary)
            }
            .accentColor(.grubRed)
            .ignoresSafeArea()
            
            LogoView(frameWidth: 125)
                .shadow(radius: 10)
        }
        .sheet(isPresented: $viewModel.isShowingOnboardingView, onDismiss: viewModel.checkIfLocationServicesIsEnabled) {
            OnboardingView(isShowingOnboardingView: $viewModel.isShowingOnboardingView)
        }
        .alert(item: $viewModel.alertItem) { $0.convertToAlert() }
        .onAppear {
            viewModel.runStartupChecks()
            
            if locationManager.locations.isEmpty {
                viewModel.fetchLocations(for: locationManager)
            }
        }
    }
}

struct LocationMapView_Previews: PreviewProvider {
    static var previews: some View {
        LocationMapView()
    }
}
