//
//  DDGProfile.swift
//  DubDubGrub
//
//  Created by Pablo Cornejo on 5/31/21.
//

import CloudKit

struct DDGProfile {
    let ckRecordID: CKRecord.ID
    let firstName: String
    let lastName: String
    let avatar: CKAsset?
    let companyName: String
    let bio: String
    let isCheckedIn: CKRecord.Reference? = nil
    
    static let kFirstName = "firstName"
    static let kLastName = "lastName"
    static let kAvatar = "avatar"
    static let kCompanyName = "companyName"
    static let kBio = "bio"
    static let kIsCheckedIn = "isCheckedIn"
    
    init(record: CKRecord) {
        ckRecordID = record.recordID
        firstName = record[DDGProfile.kFirstName] as? String ?? "N/A"
        lastName = record[DDGProfile.kLastName] as? String ?? "N/A"
        avatar = record[DDGProfile.kAvatar] as? CKAsset
        companyName = record[DDGProfile.kCompanyName] as? String ?? "N/A"
        bio = record[DDGProfile.kBio] as? String ?? "N/A"
    }
}