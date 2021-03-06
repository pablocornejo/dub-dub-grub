//
//  CloudKitManager.swift
//  DubDubGrub
//
//  Created by Pablo Cornejo on 6/1/21.
//

import CloudKit

final class  CloudKitManager {
    
    static let shared = CloudKitManager()
    
    private init() {}
    
    private(set) var userRecord: CKRecord?
    var profileRecordID: CKRecord.ID? {
        (userRecord?["userProfile"] as? CKRecord.Reference)?.recordID
    }
    
    func getUserRecord() {
        CKContainer.default().fetchUserRecordID { recordID, error in
            guard let recordID = recordID, error == nil else {
                return print(error!.localizedDescription)
            }
            
            CKContainer.default().publicCloudDatabase.fetch(withRecordID: recordID) { userRecord, error in
                guard let userRecord = userRecord, error == nil else {
                    return print(error!.localizedDescription)
                }
                
                self.userRecord = userRecord
            }
        }
    }
    
    func getLocations(completion: @escaping (Result<[DDGLocation], Error>) -> Void) {
        let nameSort = NSSortDescriptor(key: DDGLocation.kName, ascending: true)
        let query = CKQuery(recordType: RecordType.location, predicate: NSPredicate(value: true))
        query.sortDescriptors = [nameSort]
        
        CKContainer.default().publicCloudDatabase.perform(query, inZoneWith: nil) { records, error in
            if let error = error { return completion(.failure(error)) }
            
            guard let records = records else { return completion(.success([])) }
            
            let locations = records.map(DDGLocation.init(record:))
            completion(.success(locations))
        }
    }
    
    func getCheckedInProfiles(forLocationID locationID: CKRecord.ID, completion: @escaping (Result<[DDGProfile], Error>) -> Void) {
        let reference = CKRecord.Reference(recordID: locationID, action: .none)
        let predicate = NSPredicate(format: "isCheckedIn == %@", reference)
        let query = CKQuery(recordType: RecordType.profile, predicate: predicate)
        
        CKContainer.default().publicCloudDatabase.perform(query, inZoneWith: nil) { records, error in
            guard let records = records, error == nil else {
                return completion(.failure(error!))
            }

            let profiles = records.map(DDGProfile.init(record:))
            completion(.success(profiles))
        }
    }
    
    func getCheckedInProfilesDictionary(completion: @escaping (Result<[CKRecord.ID: [DDGProfile]], Error>) -> Void) {
        let predicate = NSPredicate(format: "isCheckedInNilCheck == 1")
        let query = CKQuery(recordType: RecordType.profile, predicate: predicate)
        let operation = CKQueryOperation(query: query)
//        operation.desiredKeys = [DDGProfile.kIsCheckedIn, DDGProfile.kAvatar] // can be used to make the opperation more efficient
        var checkedInProfiles: [CKRecord.ID: [DDGProfile]] = [:]
        
        operation.recordFetchedBlock = { record in
            let profile = DDGProfile(record: record)
            guard let locationID = profile.isCheckedIn?.recordID else { return }
            checkedInProfiles[locationID, default: []].append(profile)
        }
        
        operation.queryCompletionBlock = { cursor, error in
            if let error = error {
                return completion(.failure(error))
            }
            
            // handle cursor later
            
            completion(.success(checkedInProfiles))
        }
        
        CKContainer.default().publicCloudDatabase.add(operation)
    }
    
    func getCheckedInProfilesCount(completion: @escaping (Result<[CKRecord.ID: Int], Error>) -> Void) {
        let predicate = NSPredicate(format: "isCheckedInNilCheck == 1")
        let query = CKQuery(recordType: RecordType.profile, predicate: predicate)
        let operation = CKQueryOperation(query: query)
        operation.desiredKeys = [DDGProfile.kIsCheckedIn]
        var checkedInProfilesCount: [CKRecord.ID: Int] = [:]

        operation.recordFetchedBlock = { record in
            guard let locationReference = record[DDGProfile.kIsCheckedIn] as? CKRecord.Reference else { return }
            checkedInProfilesCount[locationReference.recordID, default: 0] += 1
        }

        operation.queryCompletionBlock = { cursor, error in
            if let error = error {
                return completion(.failure(error))
            }

            completion(.success(checkedInProfilesCount))
        }

        CKContainer.default().publicCloudDatabase.add(operation)
    }
    
    func batchSave(records: [CKRecord], completion: @escaping (Result<[CKRecord], Error>) -> Void) {
        
        let operation = CKModifyRecordsOperation(recordsToSave: records)
        
        operation.modifyRecordsCompletionBlock = { savedRecords, _, error in
            guard let savedRecords = savedRecords, error == nil  else {
                return completion(.failure(error!))
            }
            completion(.success(savedRecords))
        }
        
        CKContainer.default().publicCloudDatabase.add(operation)
    }
    
    func save(record: CKRecord, completion: @escaping (Result<CKRecord, Error>) -> Void) {
        CKContainer.default().publicCloudDatabase.save(record) { record, error in
            guard let record = record, error == nil else {
                return completion(.failure(error!))
            }
            completion(.success(record))
        }
    }
    
    func fetchRecord(with recordID: CKRecord.ID, completion: @escaping (Result<CKRecord, Error>) -> Void) {
        CKContainer.default().publicCloudDatabase.fetch(withRecordID: recordID) { record, error in
            guard let record = record, error == nil else {
                return completion(.failure(error!))
            }
            completion(.success(record))
        }
    }
}
