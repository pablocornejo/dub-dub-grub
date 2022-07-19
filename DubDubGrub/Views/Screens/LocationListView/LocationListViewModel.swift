//
//  LocationListViewModel.swift
//  DubDubGrub
//
//  Created by Pablo Cornejo on 7/17/22.
//

import CloudKit
import SwiftUI

final class LocationListViewModel: ObservableObject {
    
    @Published var checkedInProfiles: [CKRecord.ID: [DDGProfile]] = [:]
    
    func getCheckedInProfilesDictionary() {
        CloudKitManager.shared.getCheckedInProfilesDictionary { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let checkedInProfiles):
                    withAnimation {
                        self.checkedInProfiles = checkedInProfiles
                    }
                case .failure(_):
                    print("Error getting back dictionary")
                }                
            }
        }
    }
    
    func avatars(for location: DDGLocation) -> [UIImage] {
        checkedInProfiles[location.id, default: []]
            .map { $0.createAvatarImage() }
    }
    
    func voiceOverSummary(for location: DDGLocation) -> String {
        let count = checkedInProfiles[location.id, default: []].count
        let isPlural = count != 1
        
        return "\(location.name), \(count) \(isPlural ? "people" : "person") checked in"
    }
}
