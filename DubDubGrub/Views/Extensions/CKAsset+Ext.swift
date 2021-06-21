//
//  CKAsset+Ext.swift
//  DubDubGrub
//
//  Created by Pablo Cornejo on 6/3/21.
//

import CloudKit
import UIKit

extension CKAsset {
    func convertToUIImage(in dimension: ImageDimension) -> UIImage {
        let placeholder = dimension.placeholder
        
        guard let fileUrl = fileURL else { return placeholder }
        
        do {
            let data = try Data(contentsOf: fileUrl)
            return UIImage(data: data) ?? placeholder
        } catch {
            return placeholder
        }
    }
}
