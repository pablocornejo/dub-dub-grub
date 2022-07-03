//
//  ProfileView.swift
//  DubDubGrub
//
//  Created by Pablo Cornejo on 5/23/21.
//

import SwiftUI
import CloudKit

struct ProfileView: View {
    
    @StateObject private var viewModel = ProfileViewModel()
    
    var body: some View {
        ZStack {
            VStack(spacing: 16) {
                ZStack {
                    Color(.secondarySystemBackground)
                        .cornerRadius(16)
                        .layoutPriority(-1)
                    
                    HStack(spacing: 16) {
                        ZStack(alignment: .bottom) {
                            AvatarView(image: viewModel.avatar, size: 84)
                            EditImage()
                        }
                        .onTapGesture { viewModel.isShowingPhotoPicker = true }
                        
                        VStack(alignment: .leading, spacing: 0) {
                            TextField("First Name", text: $viewModel.firstName)
                                .profileNameStyle()
                            
                            TextField("Last Name", text: $viewModel.lastName)
                                .profileNameStyle()
                            
                            TextField("Company Name", text: $viewModel.companyName)
                        }
                    }
                    .padding()
                }
                
                HStack {
                    RemainingCharactersView(currentCount: viewModel.bio.count)
                    
                    Spacer()
                    
                    Label("Check Out", systemImage: "mappin.and.ellipse")
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .padding(8)
                        .background(RoundedRectangle(cornerRadius: 8).foregroundColor(Color(.systemPink)))
                }
                
                TextEditor(text: $viewModel.bio)
                    .frame(height: 100)
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.secondary))
                
                Spacer()
                
                Button {
                    viewModel.profileContext == .create ? viewModel.createProfile() : viewModel.updateProfile()
                } label: {
                    DDGButton(title: viewModel.profileContext == .create ? "Create Profile" : "Update Profile")
                }
                .padding(.bottom)
            }
            .padding(.horizontal)
            
            if viewModel.isLoading { LoadingView() }
        }
        .navigationTitle("Profile")
        .toolbar {
            Button {
                dismissKeyboard()
            } label: {
                Image(systemName: "keyboard.chevron.compact.down")
            }
        }
        .onAppear(perform: viewModel.getProfile)
        .alert(item: $viewModel.alertItem) { $0.convertToAlert() }
        .sheet(isPresented: $viewModel.isShowingPhotoPicker) {
            PhotoPicker(image: $viewModel.avatar)
        }
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
