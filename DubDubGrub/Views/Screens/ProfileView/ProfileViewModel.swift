//
//  ProfileViewModel.swift
//  DubDubGrub
//
//  Created by Pablo Cornejo on 7/3/22.
//

import CloudKit
import UIKit

final class ProfileViewModel: ObservableObject {
    
    @Published var firstName = ""
    @Published var lastName = ""
    @Published var companyName = ""
    @Published var bio = ""
    @Published var avatar = PlaceholderImage.avatar
    @Published var isShowingPhotoPicker = false
    @Published var alertItem: AlertItem?
    
    func isValidProfile() -> Bool {
        guard !firstName.isEmpty,
              !lastName.isEmpty,
              !bio.isEmpty,
              avatar != PlaceholderImage.avatar,
              bio.count < 100 else { return false }
        
        return true
    }
    
    func createProfile() {
        guard isValidProfile() else {
            alertItem = AlertContext.invalidProfile
            return
        }
        
        let profileRecord = createProfileRecord()
        
        // get UserRecordID from container
        CKContainer.default().fetchUserRecordID { recordID, error in
            guard let recordID = recordID, error == nil else { return print(error!.localizedDescription) }
            
            
            //  get UserRecord from public database
            CKContainer.default().publicCloudDatabase.fetch(withRecordID: recordID) { userRecord, error in
                guard let userRecord = userRecord, error == nil else { return print(error!.localizedDescription) }
                
                // create reference on user record to the DDGProfile
                userRecord["userProfile"] = CKRecord.Reference(recordID: profileRecord.recordID,
                                                               action: .none)
                
                // create CKOperation to save user and profile records
                let operation = CKModifyRecordsOperation(recordsToSave: [userRecord, profileRecord])
                operation.modifyRecordsCompletionBlock = { savedRecords, _, error in
                    guard let savedRecords = savedRecords, error == nil  else { return print(error!.localizedDescription) }
                    print("Records saved: ", savedRecords)
                }
                
                CKContainer.default().publicCloudDatabase.add(operation)
            }
        }
    }
    
    func getProfile() {
        CKContainer.default().fetchUserRecordID { recordID, error in
            guard let recordID = recordID, error == nil else { return print(error!.localizedDescription) }
            
            CKContainer.default().publicCloudDatabase.fetch(withRecordID: recordID) { userRecord, error in
                guard let userRecord = userRecord, error == nil else { return print(error!.localizedDescription) }
                
                let profileRecordReference = userRecord["userProfile"] as! CKRecord.Reference
                let profileRecordID = profileRecordReference.recordID
                
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
