//
//  LocationListView.swift
//  DubDubGrub
//
//  Created by Pablo Cornejo on 5/23/21.
//

import SwiftUI

struct LocationListView: View {
    var body: some View {
        NavigationView {
            List {
                ForEach(0..<10) { index in
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
                                AvatarView()
                                AvatarView()
                                AvatarView()
                                AvatarView()
                            }
                        }
                        .padding(.leading)
                    }
                }
            }
            .navigationTitle("Grub Spots")
        }
    }
}

struct LocationListView_Previews: PreviewProvider {
    static var previews: some View {
        LocationListView()
    }
}

struct AvatarView: View {
    var body: some View {
        Image("default-avatar")
            .resizable()
            .scaledToFit()
            .frame(width: 36, height: 36)
            .clipShape(Circle())
    }
}
