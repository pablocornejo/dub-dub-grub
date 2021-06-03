//
//  LocationMapViewModel.swift
//  DubDubGrub
//
//  Created by Pablo Cornejo on 6/1/21.
//

import Combine
import MapKit

final class LocationMapViewModel: ObservableObject {
    @Published var alertItem: AlertItem?
    @Published var region = MKCoordinateRegion(center: .init(latitude: 37.331516, longitude: -121.891054),
                                                            span: .init(latitudeDelta: 0.01, longitudeDelta: 0.01))
    
    func fetchLocations(for locationManager: LocationManager) {
        CloudKitManager.getLocations { [self] result in
            switch result {
            case .success(let locations):
                locationManager.locations = locations
            case .failure(_):
                alertItem = AlertContext.unableToGetLocations
            }
        }
    }
}
