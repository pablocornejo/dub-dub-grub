//
//  View+Ext.swift
//  DubDubGrub
//
//  Created by Pablo Cornejo on 5/27/21.
//

import SwiftUI

extension View {
    func profileNameStyle() -> some View {
        modifier(ProfileNameStyle())
    }
    
    func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
