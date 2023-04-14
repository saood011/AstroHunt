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
          
            AsyncImage(url: URL(string: astronaut.profile_image_thumnail))     .aspectRatio(contentMode: .fit)
                .frame(width: 120, height: 90)
                .cornerRadius(8)
            
            VStack(alignment: .leading, spacing: 5) {
                Text(astronaut.name)
                    .font(.title2)
                    .fontWeight(.medium)
                
                Text("Age: \(astronaut.age) years")
                    .foregroundColor(.secondary)
                    .fontWeight(.semibold)
            }
            .padding(.leading)
        }
    }
}

struct AstronautRow_Previews: PreviewProvider {
    static var previews: some View {
        AstronautRow(astronaut: MockData.sampleAstronaut)
    }
}
