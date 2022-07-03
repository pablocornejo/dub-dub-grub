//
//  LocationMapViewModel.swift
//  DubDubGrub
//
//  Created by Pablo Cornejo on 6/1/21.
//

import Combine
import MapKit

final class LocationMapViewModel: NSObject, ObservableObject {
    @Published var isShowingOnboardingView = false
    @Published var alertItem: AlertItem?
    @Published var region = MKCoordinateRegion(center: .init(latitude: 37.331516, longitude: -121.891054),
                                                            span: .init(latitudeDelta: 0.01, longitudeDelta: 0.01))
    
    var deviceLocationManager: CLLocationManager?
    
    let kHasSeenOnboardView = "hasSeenOnboardView"
    var hasSeenOnboardView: Bool { UserDefaults.standard.bool(forKey: kHasSeenOnboardView) }
    
    func runStartupChecks() {
        if !hasSeenOnboardView {
            isShowingOnboardingView = true
            UserDefaults.standard.set(true, forKey: kHasSeenOnboardView)
        } else {
            checkIfLocationServicesIsEnabled()
        }
    }
    
    func checkIfLocationServicesIsEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            deviceLocationManager = CLLocationManager()
            deviceLocationManager?.delegate = self
        } else {
            alertItem = AlertContext.locationDisabled
        }
    }
    
    private func checkLocationAuthorization() {
        guard let deviceLocationManager = deviceLocationManager else { return }
        
        switch deviceLocationManager.authorizationStatus {
        case .notDetermined:
            deviceLocationManager.requestWhenInUseAuthorization()
        case .restricted:
            alertItem = AlertContext.locationRestricted
        case .denied:
            alertItem = AlertContext.locationDenied
        case .authorizedAlways, .authorizedWhenInUse:
            break
        @unknown default:
            break
        }
    }
    
    func fetchLocations(for locationManager: LocationManager) {
        CloudKitManager.getLocations { result in
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
}

extension LocationMapViewModel: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
}
