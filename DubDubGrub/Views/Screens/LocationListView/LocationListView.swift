//
//  LocationListView.swift
//  DubDubGrub
//
//  Created by Pablo Cornejo on 5/23/21.
//

import SwiftUI

struct LocationListView: View {
    @EnvironmentObject private var locationManager: LocationManager
    @StateObject private var viewModel = LocationListViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(locationManager.locations) { location in
                    NavigationLink(destination: LocationDetailView(viewModel: .init(location: location))) {
                        LocationCell(location: location,
                                     avatars: viewModel.avatars(for: location))
                    }
                }
            }
            .navigationTitle("Grub Spots")
            .onAppear(perform: viewModel.getCheckedInProfilesDictionary)
        }
    }
}

struct LocationListView_Previews: PreviewProvider {
    static var previews: some View {
        LocationListView()
            .preferredColorScheme(.dark)
    }
}
