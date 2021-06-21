//
//  DDGLocation.swift
//  DubDubGrub
//
//  Created by Pablo Cornejo on 5/31/21.
//

import CloudKit
import UIKit

struct DDGLocation: Identifiable {
    let id: CKRecord.ID
    let name: String
    let description: String
    let squareAsset: CKAsset?
    let bannerAsset: CKAsset?
    let address: String
    let location: CLLocation
    let websiteURL: String
    let phoneNumber: String
    
    static let kName = "name"
    static let kDescription = "description"
    static let kSquareAsset = "squareAsset"
    static let kBannerAsset = "bannerAsset"
    static let kAddress = "address"
    static let kLocation = "location"
    static let kWebsiteURL = "websiteURL"
    static let kPhoneNumber = "phoneNumber"
    
    init(record: CKRecord) {
        id = record.recordID
        name = record[DDGLocation.kName] as? String ?? "N/A"
        description = record[DDGLocation.kDescription] as? String ?? "N/A"
        squareAsset = record[DDGLocation.kSquareAsset] as? CKAsset
        bannerAsset = record[DDGLocation.kBannerAsset] as? CKAsset
        address = record[DDGLocation.kAddress] as? String ?? "N/A"
        location = record[DDGLocation.kLocation] as? CLLocation ?? CLLocation(latitude: 0, longitude: 0)
        websiteURL = record[DDGLocation.kWebsiteURL] as? String ?? "N/A"
        phoneNumber = record[DDGLocation.kPhoneNumber] as? String ?? "N/A"
    }
    
    func image(for dimension: ImageDimension) -> UIImage {
        let placeholder = dimension.placeholder
        
        let asset: CKAsset?
        switch dimension {
        case .square:   asset = squareAsset
        case .banner:   asset = bannerAsset
        }
        
        return asset?.convertToUIImage(in: dimension) ?? placeholder
    }
}
