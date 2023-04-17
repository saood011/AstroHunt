//
//  AstronautRow.swift
//  AstroHunt
//
//  Created by saood.akhtar on 14.04.23.
//

import SwiftUI

struct AstronautRow: View {
    
    let astronaut : Astronaut
    
    var body: some View {
        HStack {
          
            AsyncImage(url: URL(string: astronaut.profileImageThumbnail))
                .clipShape(Rectangle()).frame(width: 100, height: 100)
                .cornerRadius(18)
                .overlay {
                    Rectangle().stroke(.white, lineWidth: 8)
                }
                .cornerRadius(8)
                .shadow(radius: 7)
                .frame(width: 120,height: 90).scaledToFit()
            
            VStack(alignment: .leading, spacing: 5) {
                Text(astronaut.name)
                    .font(.title2)
                    .fontWeight(.medium)
                
                Text("Age: \(String(astronaut.age)) years")
                    .foregroundColor(.secondary)
                    .fontWeight(.semibold)
            }
        }
    }
}

struct AstronautRow_Previews: PreviewProvider {
    static var previews: some View {
        AstronautRow(astronaut: MockData.sampleAstronaut).environmentObject(Network())
    }
}
