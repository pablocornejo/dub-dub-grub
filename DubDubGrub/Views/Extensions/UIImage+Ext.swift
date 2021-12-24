//
//  UIImage+Ext.swift
//  DubDubGrub
//
//  Created by Pablo Cornejo on 12/24/21.
//

import CloudKit
import UIKit

extension UIImage {
    func convertToCKAsset() -> CKAsset? {
        guard let urlPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first,
              let imageData = jpegData(compressionQuality: 0.25) else { return nil }
        
        do {
            let fileUrl = urlPath.appendingPathComponent("selectedAvatarImage")
            try imageData.write(to: fileUrl)
            return CKAsset(fileURL: fileUrl)
        } catch {
            return nil
        }
    }
}

