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
                MapAnnotation(coordinate: location.location.coordinate, anchorPoint: CGPoint(x: 0.5, y: 0.75)) {
                    DDGAnnotation(location: location)
                        .onTapGesture {
                            viewModel.selectedLocation = location
                        }
                }
            }
            .accentColor(.grubRed)
            .ignoresSafeArea()
            
            LogoView(frameWidth: 125)
                .shadow(radius: 10)
        }
        .sheet(item: $viewModel.selectedLocation) { location in
            NavigationView {
                LocationDetailView(viewModel: .init(location: location))
                    .toolbar {
                        Button("Dismiss") { viewModel.selectedLocation = nil }
                    }
            }
            .accentColor(.brandPrimary)
        }
        .alert(item: $viewModel.alertItem) { $0.convertToAlert() }
        .onAppear {
            if locationManager.locations.isEmpty {
                viewModel.fetchLocations(for: locationManager)
            }
        }
    }
}

struct LocationMapView_Previews: PreviewProvider {
    static var previews: some View {
        LocationMapView()
            .environmentObject(LocationManager())
    }
}
