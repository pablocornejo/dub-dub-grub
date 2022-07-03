//
//  ProfileViewModel.swift
//  DubDubGrub
//
//  Created by Pablo Cornejo on 7/3/22.
//

import CloudKit
import UIKit

enum ProfileContext { case create, update }

final class ProfileViewModel: ObservableObject {
    
    @Published var firstName = ""
    @Published var lastName = ""
    @Published var companyName = ""
    @Published var bio = ""
    @Published var avatar = PlaceholderImage.avatar
    @Published var isShowingPhotoPicker = false
    @Published var isLoading = false
    @Published var alertItem: AlertItem?
    
    private var existingProfileRecord: CKRecord? {
        didSet { profileContext = .update }
    }
    var profileContext: ProfileContext = .create
    
    func isValidProfile() -> Bool {
        guard !firstName.isEmpty,
              !lastName.isEmpty,
              !bio.isEmpty,
              avatar != PlaceholderImage.avatar,
              bio.count <= 100 else { return false }
        
        return true
    }
    
    func createProfile() {
        guard isValidProfile() else {
            alertItem = AlertContext.invalidProfile
            return
        }
        
        let profileRecord = createProfileRecord()
        
        guard let userRecord = CloudKitManager.shared.userRecord else {
            alertItem = AlertContext.noUserRecord
            return
        }
                
        // create reference on user record to the DDGProfile
        userRecord["userProfile"] = CKRecord.Reference(recordID: profileRecord.recordID,
                                                       action: .none)
        
        
        isLoading = true
        CloudKitManager.shared.batchSave(records: [userRecord, profileRecord]) { result in
            DispatchQueue.main.async { [self] in
                isLoading = false
                switch result {
                case .success(let records):
                    existingProfileRecord = records.first { $0.recordType == RecordType.profile }
                    
                    alertItem = AlertContext.createProfileSuccess
                    break
                case .failure(_):
                    alertItem = AlertContext.createProfileFailure
                    break
                }
            }
        }
    }
    
    func getProfile() {
        guard let userRecord = CloudKitManager.shared.userRecord else {
            alertItem = AlertContext.noUserRecord
            return
        }
                
        guard let profileRecordReference = userRecord["userProfile"] as? CKRecord.Reference else { return }
        
        let profileRecordID = profileRecordReference.recordID
        
        isLoading = true
        CloudKitManager.shared.fetchRecord(with: profileRecordID) { result in
            DispatchQueue.main.async { [self] in
                isLoading = false
                switch result {
                case .success(let profileRecord):
                    existingProfileRecord = profileRecord
                    
                    let profile = DDGProfile(record: profileRecord)
                    firstName = profile.firstName
                    lastName = profile.lastName
                    companyName = profile.companyName
                    bio = profile.bio
                    avatar = profile.createAvatarImage()
                case .failure(_):
                    alertItem = AlertContext.unableToGetProfile
                    break
                }
            }
        }
        
        CKContainer.default().publicCloudDatabase.fetch(withRecordID: profileRecordID) { profileRecord, error in
            guard let profileRecord = profileRecord, error == nil else { return print(error!.localizedDescription) }
            
            DispatchQueue.main.async { [self] in
                let profile = DDGProfile(record: profileRecord)
                firstName = profile.firstName
                lastName = profile.lastName
                companyName = profile.companyName
                bio = profile.bio
                avatar = profile.createAvatarImage()
            }
        }
    }
    
    func updateProfile() {
        guard isValidProfile() else {
            alertItem = AlertContext.invalidProfile
            return
        }
        
        guard let profileRecord = existingProfileRecord else {
            alertItem = AlertContext.unableToGetProfile
            return
        }
        
        profileRecord[DDGProfile.kFirstName] = firstName
        profileRecord[DDGProfile.kLastName] = lastName
        profileRecord[DDGProfile.kAvatar] = avatar.convertToCKAsset()
        profileRecord[DDGProfile.kCompanyName] = companyName
        profileRecord[DDGProfile.kBio] = bio
        
        isLoading = true
        CloudKitManager.shared.save(record: profileRecord) { result in
            DispatchQueue.main.async { [self] in
                isLoading = false
                
                switch result {
                case .success(let record):
                    existingProfileRecord = record
                    
                    alertItem = AlertContext.updateProfileSuccess
                    break
                case .failure(_):
                    alertItem = AlertContext.updateProfileFailure
                    break
                }
            }
        }
    }
    
    private func createProfileRecord() -> CKRecord {
        let profileRecord = CKRecord(recordType: RecordType.profile)
        profileRecord[DDGProfile.kFirstName] = firstName
        profileRecord[DDGProfile.kLastName] = lastName
        profileRecord[DDGProfile.kAvatar] = avatar.convertToCKAsset()
        profileRecord[DDGProfile.kCompanyName] = companyName
        profileRecord[DDGProfile.kBio] = bio
        
        return profileRecord
    }
}
