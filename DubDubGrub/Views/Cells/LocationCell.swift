//
//  LocationCell.swift
//  DubDubGrub
//
//  Created by Pablo Cornejo on 5/26/21.
//

import SwiftUI

struct LocationCell: View {
    var body: some View {
        HStack {
            Image("default-square-asset")
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .clipShape(Circle())
                .padding(.vertical, 8)
            
            VStack(alignment: .leading) {
                Text("Test location name")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
                
                HStack {
                    AvatarView(size: 36)
                    AvatarView(size: 36)
                    AvatarView(size: 36)
                    AvatarView(size: 36)
                }
            }
            .padding(.leading)
        }
    }
}

struct LocationCell_Previews: PreviewProvider {
    static var previews: some View {
        LocationCell()
    }
}
