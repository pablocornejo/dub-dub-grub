//
//  CloudKitManager.swift
//  DubDubGrub
//
//  Created by Pablo Cornejo on 6/1/21.
//

import CloudKit

enum CloudKitManager {
    static func getLocations(completion: @escaping (Result<[DDGLocation], Error>) -> Void) {
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
}
