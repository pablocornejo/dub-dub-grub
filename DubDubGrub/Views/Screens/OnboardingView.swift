//
//  OnboardingView.swift
//  DubDubGrub
//
//  Created by Pablo Cornejo on 6/27/21.
//

import SwiftUI

struct OnboardingView: View {
    @Binding var isShowingOnboardingView: Bool
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button {
                    isShowingOnboardingView = false
                } label: {
                    XDismissButton()
                }
                .padding()
            }
            
            Spacer()
            
            LogoView(frameWidth: 250)
                .padding(.bottom)
            
            VStack(alignment: .leading, spacing: 32) {
                OnboardInfoView(imageName: "building.2.crop.circle",
                                title: "Restaurant Locations",
                                description: "Find places to dine around the convention center.")
                
                OnboardInfoView(imageName: "checkmark.circle",
                                title: "Check In",
                                description: "Let other iOS devs know where you are.")
                
                OnboardInfoView(imageName: "person.2.circle",
                                title: "Restaurant Locations",
                                description: "See where other iOS devs are and join the party.")
            }
            .padding(.horizontal, 40)
            
            Spacer()
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(isShowingOnboardingView: .constant(true))
    }
}

struct OnboardInfoView: View {
    let imageName: String
    let title: String
    let description: String
    
    var body: some View {
        HStack(spacing: 26) {
            Image(systemName: imageName)
                .resizable()
                .frame(width: 50, height: 50)
                .foregroundColor(.brandPrimary)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title).bold()
                
                Text(description)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
                    .minimumScaleFactor(0.75)
            }
        }
    }
}
