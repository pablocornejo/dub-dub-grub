//
//  LocationDetailView.swift
//  DubDubGrub
//
//  Created by Pablo Cornejo on 5/23/21.
//

import SwiftUI

struct LocationDetailView: View {
    let location: DDGLocation
    let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        VStack(spacing: 16) {
            BannerImage(image: location.image(for: .banner))
            
            HStack {
                AddressView(address: location.address)
                Spacer()
            }
            .padding(.horizontal)
            
            DescriptionView(text: location.description)
            
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
                    
                    Link(destination: URL(string: location.websiteURL)!) {
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
            
            ScrollView {
                LazyVGrid(columns: columns) {
                    FirstNameAvatarView(firstName: "Pablo")
                    FirstNameAvatarView(firstName: "Pablo")
                    FirstNameAvatarView(firstName: "Pablo")
                    FirstNameAvatarView(firstName: "Pablo")
                    FirstNameAvatarView(firstName: "Pablo")
                    FirstNameAvatarView(firstName: "Pablo")
                    FirstNameAvatarView(firstName: "Pablo")
                }
            }
        }
        .navigationTitle(location.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct LocationDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            LocationDetailView(location: DDGLocation(record: MockData.location))
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
            AvatarView(image: PlaceholderImage.avatar, size: 64)
            
            Text(firstName)
                .bold()
                .lineLimit(1)
                .minimumScaleFactor(0.8)
        }
    }
}

struct BannerImage: View {
    let image: UIImage
    
    var body: some View {
        Image(uiImage: image)
            .resizable()
            .scaledToFill()
            .frame(height: 120)
    }
}

struct AddressView: View {
    let address: String
    
    var body: some View {
        Label(address, systemImage: "mappin.and.ellipse")
            .font(.caption)
            .foregroundColor(.secondary)
    }
}

struct DescriptionView: View {
    let text: String
    
    var body: some View {
        Text(text)
            .lineLimit(3)
            .minimumScaleFactor(0.8)
            .padding(.horizontal)
    }
}
