//
//  LocationCell.swift
//  DubDubGrub
//
//  Created by Pablo Cornejo on 5/26/21.
//

import SwiftUI

private extension CGFloat {
    static let avatarSize: CGFloat = 35
}

struct LocationCell: View {
    let location: DDGLocation
    let avatars: [UIImage]
    
    var body: some View {
        HStack {
            Image(uiImage: location.image(for: .square))
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .clipShape(Circle())
                .padding(.vertical, 8)
            
            VStack(alignment: .leading) {
                Text(location.name)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
                
                if avatars.isEmpty {
                    Text("Nobody's checked in")
                        .fontWeight(.semibold)
                        .foregroundColor(.secondary)
                        .padding(.top, 2)
                } else {
                    HStack {
                        ForEach(avatars.indices, id: \.self) { index in
                            let maxAvatars = 3
                            if index < maxAvatars {
                                AvatarView(image: avatars[index], size: .avatarSize)
                            } else if index == maxAvatars {
                                AdditionalProfilesView(number: avatars.count - 4)
                            }
                        }
                    }
                }
            }
            .padding(.leading)
        }
    }
}

struct LocationCell_Previews: PreviewProvider {
    static var previews: some View {
        LocationCell(location: DDGLocation(record: MockData.location), avatars: [])
    }
}

struct AdditionalProfilesView: View {
    
    let number: Int
    
    var body: some View {
        Text("+\(number)")
            .font(.system(size: 14, weight: .semibold))
            .frame(width: .avatarSize, height: .avatarSize)
            .foregroundColor(.white)
            .background(Color.brandPrimary)
            .clipShape(Circle())
    }
}
