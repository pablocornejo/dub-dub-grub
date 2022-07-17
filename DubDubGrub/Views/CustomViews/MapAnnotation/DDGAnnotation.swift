//
//  DDGAnnotation.swift
//  DubDubGrub
//
//  Created by Pablo Cornejo on 7/17/22.
//

import SwiftUI

struct DDGAnnotation: View {
    
    let location: DDGLocation
    let count: Int
    
    var body: some View {
        VStack {
            ZStack {
                MapBalloon()
                    .frame(width: 100, height: 70)
                    .foregroundColor(.brandPrimary)
                
                Image(uiImage: location.image(for: .square))
                    .resizable()
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                    .offset(y: -11)
                
                if count > 0 {
                    Text(count < 100 ? "\(count)" : "+\(99)")
                        .font(.system(size: 11, weight: .bold))
                        .padding(.horizontal, 6)
                        .frame(height: 18)
                        .background(Color.grubRed)
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                        .offset(x: 20, y: -28)
                }
            }
            
            Text(location.name)
                .font(.caption)
                .fontWeight(.semibold)
        }
    }
}

struct DDGAnnotation_Previews: PreviewProvider {
    static var previews: some View {
        DDGAnnotation(location: DDGLocation(record: MockData.location), count: 44)
    }
}
