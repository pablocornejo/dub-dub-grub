//
//  DDGButton.swift
//  DubDubGrub
//
//  Created by Pablo Cornejo on 5/27/21.
//

import SwiftUI

struct DDGButton: View {
    let title: String
    
    var body: some View {
        Text(title)
            .foregroundColor(.white)
            .bold()
            .frame(width: 280, height: 44)
            .background(Color.brandPrimary)
            .cornerRadius(8)
    }
}

struct DDGButton_Previews: PreviewProvider {
    static var previews: some View {
        DDGButton(title: "Test Button")
    }
}
