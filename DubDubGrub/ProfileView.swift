//
//  ProfileView.swift
//  DubDubGrub
//
//  Created by Pablo Cornejo on 5/23/21.
//

import SwiftUI

struct ProfileView: View {
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var companyName = ""
    @State private var bio = ""
    
    var body: some View {
        VStack(spacing: 16) {
                ZStack {
                    Color(.secondarySystemBackground)
                        .layoutPriority(-1)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                    
                    HStack(spacing: 16) {
                        ZStack(alignment: .bottom) {
                            AvatarView(size: 84)
                            Image(systemName: "square.and.pencil")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 14)
                                .foregroundColor(.white)
                                .padding(.bottom, 4)
                        }
                        
                        VStack(alignment: .leading, spacing: 0) {
                            TextField("First Name", text: $firstName)
                                .font(.system(size: 32, weight: .bold))
                                .minimumScaleFactor(0.8)
                            
                            TextField("Last Name", text: $lastName)
                                .font(.system(size: 32, weight: .bold))
                                .minimumScaleFactor(0.8)
                            
                            TextField("Company Name", text: $companyName)
                        }
                    }
                    .padding()
                }
                
                HStack {
                    Text("Bio: \(remainingCharactersText) characters remain")
                        .font(.callout)
                        .bold()
                        .foregroundColor(.secondary)
                    
                    Spacer()
                    
                    Label("Check Out", systemImage: "mappin.and.ellipse")
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .padding(8)
                        .background(RoundedRectangle(cornerRadius: 8).foregroundColor(Color(.systemPink)))
                }
                
                TextEditor(text: $bio)
                    .frame(height: 100)
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.secondary))
                
                Spacer()
                
                Button {
                    
                } label: {
                    Text("Save Profile")
                        .foregroundColor(.white)
                        .bold()
                        .frame(width: 280, height: 44)
                        .background(Color.brandPrimary)
                        .cornerRadius(8)
                }
            }
            .padding(.horizontal)
            .navigationTitle("Profile")
    }
    
    private var remainingCharacters: Int { 100 - bio.count }
    
    private var remainingCharactersText: Text {
        Text("\(remainingCharacters)")
            .foregroundColor(remainingCharacters >= 0 ? .brandPrimary : .red)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProfileView()
                .preferredColorScheme(.dark)
        }
    }
}
