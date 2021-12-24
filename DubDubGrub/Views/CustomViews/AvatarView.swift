//
//  AvatarView.swift
//  DubDubGrub
//
//  Created by Pablo Cornejo on 5/26/21.
//

import SwiftUI

struct AvatarView: View {
    let image: UIImage
    let size: CGFloat
    
    var body: some View {
        Image(uiImage: image)
            .resizable()
            .scaledToFit()
            .frame(width: size, height: size)
            .clipShape(Circle())
    }
}

struct AvatarView_Previews: PreviewProvider {
    static var previews: some View {
        AvatarView(image: PlaceholderImage.avatar, size: 90)
    }
}
