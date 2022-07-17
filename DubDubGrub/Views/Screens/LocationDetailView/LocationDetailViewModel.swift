//
//  LocationDetailViewModel.swift
//  DubDubGrub
//
//  Created by Pablo Cornejo on 7/3/22.
//

import SwiftUI
import MapKit
import CloudKit

enum CheckInStatus { case checkedIn, checkedOut }

final class LocationDetailViewModel: ObservableObject {
    
    @Published var checkedInProfiles: [DDGProfile] = []
    @Published var isShowingProfileModal = false
    @Published var isCheckedIn = false
    @Published var isLoading = false
    @Published var alertItem: AlertItem?
    
    let location: DDGLocation
    let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    init(location: DDGLocation) {
        self.location = location
    }
    
    func getDirectionsToLocation() {
        let placemark = MKPlacemark(coordinate: location.location.coordinate)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = location.name
        
        mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeDefault: MKLaunchOptionsDirectionsModeWalking])
    }
    
    func callLocation() {
        guard let url = URL(string: "tel://\(location.phoneNumber)") else {
            alertItem = AlertContext.invalidPhoneNumber
            return
        }
        
        UIApplication.shared.open(url)
    }
    
    func getCheckedInStatus() {
        guard let profileRecordID = CloudKitManager.shared.profileRecordID else { return }
        
        CloudKitManager.shared.fetchRecord(with: profileRecordID) { [self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let profileRecord):
                    if let reference = profileRecord[DDGProfile.kIsCheckedIn] as? CKRecord.Reference {
                        self.isCheckedIn = reference.recordID == self.location.id
                    } else {
                        self.isCheckedIn = false
                    }
                case .failure(_):
                    self.alertItem = AlertContext.unableToGetCheckInStatus
                }
            }
        }
    }
    
    func updateCheckInStatus(to checkInStatus: CheckInStatus) {
        guard let profileRecordID = CloudKitManager.shared.profileRecordID else {
            alertItem = AlertContext.unableToGetProfile
            return
        }
        
        CloudKitManager.shared.fetchRecord(with: profileRecordID) { [self] result in
            switch result {
            case .success(let record):
                switch checkInStatus {
                case .checkedIn:
                    record[DDGProfile.kIsCheckedIn] = CKRecord.Reference(recordID: location.id, action: .none)
                    record[DDGProfile.kIsCheckedInNilCheck] = 1
                case .checkedOut:
                    record[DDGProfile.kIsCheckedIn] = nil
                    record[DDGProfile.kIsCheckedInNilCheck] = nil
                }
                
                CloudKitManager.shared.save(record: record) { result in
                    DispatchQueue.main.async { [self] in
                        switch result {
                        case .success(let record):
                            let profile = DDGProfile(record: record)
                            switch checkInStatus {
                            case .checkedIn:
                                checkedInProfiles.append(profile)
                            case .checkedOut:
                                checkedInProfiles.removeAll { $0.id == profile.id }
                            }
                            
                            isCheckedIn = checkInStatus == .checkedIn
                        case .failure(_):
                            alertItem = AlertContext.unableToCheckInOrOut
                        }
                    }
                }
            case .failure(_):
                alertItem = AlertContext.unableToCheckInOrOut
            }
        }
    }
    
    func getCheckedInProfiles() {
        isLoading = true
        CloudKitManager.shared.getCheckedInProfiles(forLocationID: location.id) { result in
            DispatchQueue.main.async { [self] in
                switch result {
                case .success(let profiles):
                    self.checkedInProfiles = profiles
                case .failure(_):
                    alertItem = AlertContext.unableToGetCheckedInProfiles
                }
                isLoading = false
            }
        }
    }
}
