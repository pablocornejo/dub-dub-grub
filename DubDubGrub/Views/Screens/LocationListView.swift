//
//  LocationListView.swift
//  DubDubGrub
//
//  Created by Pablo Cornejo on 5/23/21.
//

import SwiftUI

struct LocationListView: View {
    @EnvironmentObject private var locationManager: LocationManager
    
    var body: some View {
        NavigationView {
            List {
                ForEach(locationManager.locations) { location in
                    NavigationLink(destination: LocationDetailView(viewModel: .init(location: location))) {
                        LocationCell(location: location)
                    }
                }
            }
            .navigationTitle("Grub Spots")
            .onAppear {
                CloudKitManager.shared.getCheckedInProfilesDictionary { result in
                    switch result {
                    case .success(let checkedInProfiles):
                        print(checkedInProfiles)
                    case .failure(_):
                        print("Error getting back dictionary")
                    }
                }
            }
        }
    }
}

struct LocationListView_Previews: PreviewProvider {
    static var previews: some View {
        LocationListView()
            .preferredColorScheme(.dark)
    }
}
