//
//  LocationMapView.swift
//  DubDubGrub
//
//  Created by Pablo Cornejo on 5/23/21.
//

import SwiftUI
import MapKit

struct LocationMapView: View {
    @StateObject private var viewModel = LocationMapViewModel()
    
    var body: some View {
        ZStack(alignment: .top) {
            Map(coordinateRegion: $viewModel.region)
                .ignoresSafeArea()
            
            LogoView()
                .shadow(radius: 10)
        }
        .alert(item: $viewModel.alertItem) { $0.convertToAlert() }
        .onAppear { viewModel.fetchLocations() }
    }
}

struct LocationMapView_Previews: PreviewProvider {
    static var previews: some View {
        LocationMapView()
    }
}

struct LogoView: View {
    var body: some View {
        Image("ddg-map-logo")
            .resizable()
            .scaledToFit()
            .frame(height: 70)
    }
}
