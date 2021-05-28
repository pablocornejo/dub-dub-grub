//
//  CustomModifiers.swift
//  DubDubGrub
//
//  Created by Pablo Cornejo on 5/27/21.
//

import SwiftUI

struct ProfileNameStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 32, weight: .bold))
            .minimumScaleFactor(0.8)
    }
}
