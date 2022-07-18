//
//  LogoView.swift
//  DubDubGrub
//
//  Created by Pablo Cornejo on 6/27/21.
//

import SwiftUI

struct LogoView: View {
    let frameWidth: CGFloat
    
    var body: some View {
        Image(decorative: "ddg-map-logo") // decorative makes the image not be included as a voice over item
            .resizable()
            .scaledToFit()
            .frame(width: frameWidth)
    }
}

struct LogoView_Previews: PreviewProvider {
    static var previews: some View {
        LogoView(frameWidth: 250)
    }
}
