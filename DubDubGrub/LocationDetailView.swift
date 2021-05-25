//
//  LocationDetailView.swift
//  DubDubGrub
//
//  Created by Pablo Cornejo on 5/23/21.
//

import SwiftUI

struct LocationDetailView: View {
    let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        VStack(spacing: 16) {
            Image("default-banner-asset")
                .resizable()
                .scaledToFill()
                .frame(height: 120)
            
            HStack {
                Label("123 Main Street", systemImage: "mappin.and.ellipse")
                    .font(.caption)
                    .foregroundColor(.secondary)
                Spacer()
            }
            .padding(.horizontal)
            
            Text("This is a test description. This is a test description. This is a test description. This is a test description. This is a test description.")
                .lineLimit(3)
                .minimumScaleFactor(0.8)
                .padding(.horizontal)
            
            ZStack {
                Capsule()
                    .frame(height: 80)
                    .foregroundColor(Color(.secondarySystemBackground))
                
                HStack {
                    Button {
                        
                    } label: {
                        LocationActionButton(color: .brandPrimary, imageName: "location.fill")
                    }
                    
                    Spacer()
                    
                    Link(destination: URL(string: "https://www.apple.com")!) {
                        LocationActionButton(color: .brandPrimary, imageName: "network")
                    }
                    
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        LocationActionButton(color: .brandPrimary, imageName: "phone.fill")
                    }
                    
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        LocationActionButton(color: .brandPrimary, imageName: "person.fill.checkmark")
                    }
                }
                .padding(.horizontal, 10)
            }
            .padding(.horizontal)
            
             Text("Who's Here?")
                .bold()
                .font(.title2)
            
            LazyVGrid(columns: columns) {
                FirstNameAvatarView(firstName: "Pablo")
                FirstNameAvatarView(firstName: "Pablo")
                FirstNameAvatarView(firstName: "Pablo")
                FirstNameAvatarView(firstName: "Pablo")
                FirstNameAvatarView(firstName: "Pablo")
            }
            
            Spacer()
        }
        .navigationTitle("Location Name")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct LocationDetailView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LocationDetailView()
                .preferredColorScheme(.dark)
        }
            
    }
}

struct LocationActionButton: View {
    let color: Color
    let imageName: String
    
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(color)
            
            Image(systemName: imageName)
                .resizable()
                .scaledToFit()
                .foregroundColor(.white)
                .frame(width: 22)
        }
        .frame(width: 60, height: 60)
    }
}

struct FirstNameAvatarView: View {
    let firstName: String
    
    var body: some View {
        VStack {
            AvatarView(size: 64)
            
            Text(firstName)
                .bold()
                .lineLimit(1)
                .minimumScaleFactor(0.8)
        }
    }
}
