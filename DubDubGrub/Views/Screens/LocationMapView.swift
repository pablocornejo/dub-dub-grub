//
//  LocationMapView.swift
//  DubDubGrub
//
//  Created by Pablo Cornejo on 5/23/21.
//

import SwiftUI
import MapKit

struct LocationMapView: View {
    @State private var region = MKCoordinateRegion(center: .init(latitude: 37.331516, longitude: -121.891054),
                                                   span: .init(latitudeDelta: 0.01, longitudeDelta: 0.01))
    
    var body: some View {
        ZStack(alignment: .top) {
            Map(coordinateRegion: $region)
                .ignoresSafeArea()
            
            LogoView()
                .shadow(radius: 10)
        }
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
