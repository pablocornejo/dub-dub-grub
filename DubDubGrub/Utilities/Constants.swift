//
//  Constants.swift
//  DubDubGrub
//
//  Created by Pablo Cornejo on 6/1/21.
//

import UIKit

enum RecordType {
    static let location = "DDGLocation"
    static let profile = "DDGProfile"
}

enum PlaceholderImage {
    static let avatar = UIImage(named: "default-avatar")!
    static let square = UIImage(named: "default-square-asset")!
    static let banner = UIImage(named: "default-banner-asset")!
}

enum ImageDimension {
    case square, banner
    
    var placeholder: UIImage {
        switch self {
        case .square: return PlaceholderImage.square
        case .banner: return PlaceholderImage.banner
        }
    }
    
    func getPlaceholder(for dimension: ImageDimension) -> UIImage {
        switch dimension {
        case .square: return PlaceholderImage.square
        case .banner: return PlaceholderImage.banner
        }
    }
}
