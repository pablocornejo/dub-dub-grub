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
    @State private var avatar = PlaceholderImage.avatar
    @State private var isShowingPhotoPicker = false
    @State private var alertItem: AlertItem?
    
    var body: some View {
        VStack(spacing: 16) {
                ZStack {
                    Color(.secondarySystemBackground)
                        .cornerRadius(16)
                        .layoutPriority(-1)
                    
                    HStack(spacing: 16) {
                        ZStack(alignment: .bottom) {
                            AvatarView(image: avatar, size: 84)
                            EditImage()
                        }
                        .onTapGesture { isShowingPhotoPicker = true }
                        
                        VStack(alignment: .leading, spacing: 0) {
                            TextField("First Name", text: $firstName)
                                .profileNameStyle()
                            
                            TextField("Last Name", text: $lastName)
                                .profileNameStyle()
                            
                            TextField("Company Name", text: $companyName)
                        }
                    }
                    .padding()
                }
                
                HStack {
                    RemainingCharactersView(currentCount: bio.count)
                    
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
                    createProfile()
                } label: {
                    DDGButton(title: "Save Profile")
                }
                .padding(.bottom)
            }
            .padding(.horizontal)
            .navigationTitle("Profile")
            .toolbar {
                Button {
                    dismissKeyboard()
                } label: {
                    Image(systemName: "keyboard.chevron.compact.down")
                }
            }
            .alert(item: $alertItem) { $0.convertToAlert() }
            .sheet(isPresented: $isShowingPhotoPicker) {
                PhotoPicker(image: $avatar)
            }
    }
    
    func isValidProfile() -> Bool {
        guard !firstName.isEmpty,
              !lastName.isEmpty,
              !bio.isEmpty,
              avatar != PlaceholderImage.avatar,
              bio.count < 100 else { return false }
        
        return true
    }
    
    func createProfile() {
        guard isValidProfile() else {
            alertItem = AlertContext.invalidProfile
            return
        }
        
        // create profile and send it to CloudKit
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

struct EditImage: View {
    var body: some View {
        Image(systemName: "square.and.pencil")
            .resizable()
            .scaledToFit()
            .frame(width: 14)
            .foregroundColor(.white)
            .padding(.bottom, 4)
    }
}

struct RemainingCharactersView: View {
    let currentCount: Int
    let maxCount: Int = 100
    
    var body: some View {
        Group {
            Text("Bio: ")
            +
            Text("\(maxCount - currentCount)")
                .bold()
                .foregroundColor(currentCount <= maxCount ? .brandPrimary : .grubRed)
            +
            Text(" characters remain")
        }
        .font(.callout)
        .foregroundColor(.secondary)
    }
}
