//
//  AstronautCardView.swift
//  AstroHunt
//
//  Created by saood.akhtar on 02.05.23.
//

import SwiftUI
import NukeUI

struct AstronautCardView: View {
    var astronauts: [Astronaut]

    var body: some View {
        NavigationView {
            List(astronauts) { astronaut in
                
                CardView(astronaut: astronaut).background(NavigationLink("", destination: DetailView(astronaut: astronaut)).opacity(0))
                
            }.listStyle(.inset).navigationTitle("All Astronauts")
        }
        
    }
}

struct AstronautCardView_Previews: PreviewProvider {
    static var previews: some View {
        AstronautCardView(astronauts: MockData.astronauts)
    }
}

struct CardView: View {
    var astronaut: Astronaut
    var body: some View {
        VStack {
            LazyImage(url: URL(string: astronaut.profileImage)) { state in
                if let image = state.image {
                    image.resizable().aspectRatio(contentMode: .fit)
                } else if state.error != nil {
                    Color.red // Indicates an error
                } else {
                    Color.blue // Acts as a placeholder
                }
            }
            
            HStack {
                VStack(alignment: .leading) {
                    Text(astronaut.name)
                        .font(.title)
                        .fontWeight(.black)
                        .foregroundColor(.primary)
                        .lineLimit(3)
                    Text("\(astronaut.nationality) - \(astronaut.age) years old")
                        .font(.headline)
                        .foregroundColor(.secondary)
                }
                .layoutPriority(100)
                
                Spacer()
            }
            
            .padding()
        }.cornerRadius(10).overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.2), lineWidth: 3)
        )
        .padding([.top, .horizontal])
    }
}
