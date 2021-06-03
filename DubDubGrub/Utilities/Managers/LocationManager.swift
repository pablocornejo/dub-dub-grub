//
//  LocationManager.swift
//  DubDubGrub
//
//  Created by Pablo Cornejo on 6/2/21.
//

import Foundation

final class LocationManager: ObservableObject {
    @Published var locations: [DDGLocation] = []
}
