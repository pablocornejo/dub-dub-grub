//
//  MockData.swift
//  DubDubGrub
//
//  Created by Pablo Cornejo on 5/31/21.
//

import CloudKit

enum MockData {
    static var location: CKRecord {
        let record = CKRecord(recordType: RecordType.location)
        record[DDGLocation.kName] = "Pablo's Bar and Grill"
        record[DDGLocation.kAddress] = "123 Main Street"
        record[DDGLocation.kDescription] = "This is a test description. Isn't it awesome. Not sure how long to make it to test the three lines."
        record[DDGLocation.kWebsiteURL] = "https://linkedin.com/in/pablo.cornejo"
        record[DDGLocation.kLocation] = CLLocation(latitude: 37.331516, longitude: -121.891054)
        record[DDGLocation.kPhoneNumber] = "111-123-1234"
        return record
    }
}
