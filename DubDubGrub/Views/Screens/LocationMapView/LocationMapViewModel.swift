//
//  LocationMapViewModel.swift
//  DubDubGrub
//
//  Created by Pablo Cornejo on 6/1/21.
//

import MapKit
import CloudKit

final class LocationMapViewModel: ObservableObject {
    
    @Published var alertItem: AlertItem?
    @Published var region = MKCoordinateRegion(center: .init(latitude: 37.331516, longitude: -121.891054),
                                                            span: .init(latitudeDelta: 0.01, longitudeDelta: 0.01))
    @Published var selectedLocation: DDGLocation?
    @Published var checkedInProfilesCount: [CKRecord.ID: Int] = [:]
    
    func fetchLocations(for locationManager: LocationManager) {
        CloudKitManager.shared.getLocations { result in
            DispatchQueue.main.async { [self] in
                switch result {
                case .success(let locations):
                    locationManager.locations = locations
                case .failure(_):
                    alertItem = AlertContext.unableToGetLocations
                }                
            }
        }
    }
    
    func getCheckedInCounts() {
        CloudKitManager.shared.getCheckedInProfilesCount { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let checkedInProfilesCount):
                    self.checkedInProfilesCount = checkedInProfilesCount
                case .failure(let error):
                    // show alert
                    print(error)
                }
            }
        }
    }
}
