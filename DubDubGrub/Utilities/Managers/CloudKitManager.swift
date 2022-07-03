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
    
    func fetchRecord(with recordID: CKRecord.ID, completion: @escaping (Result<CKRecord, Error>) -> Void) {
        CKContainer.default().publicCloudDatabase.fetch(withRecordID: recordID) { record, error in
            guard let record = record, error == nil else {
                return completion(.failure(error!))
            }
            completion(.success(record))
        }
    }
}
