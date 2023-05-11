//
//  AstronautRow.swift
//  AstroHunt
//
//  Created by saood.akhtar on 14.04.23.
//

import SwiftUI
import NukeUI

struct AstronautRow: View {
    
    let astronaut : Astronaut
    
    var body: some View {
        HStack {
            RectangleImage(url: URL(string: astronaut.profileImageThumbnail)!)
            
            VStack(alignment: .leading, spacing: 5) {
                Text(astronaut.name)
                    .font(.title2)
                    .fontWeight(.medium)
                
                Text("Age: \(String(astronaut.age)) years")
                    .foregroundColor(.secondary)
                    .fontWeight(.semibold)
            }
            Spacer()
        }
    }
}

struct AstronautRow_Previews: PreviewProvider {
    static var previews: some View {
        AstronautRow(astronaut: MockData.sampleAstronaut).environmentObject(Network())
    }
}

