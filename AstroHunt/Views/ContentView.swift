//
//  ContentView.swift
//  AstroHunt
//
//  Created by saood.akhtar on 14.04.23.
//

import SwiftUI

struct ContentView: View {
    
    var astronauts: [Astronaut] = MockData.astronauts
    
    var body: some View {
        VStack {
            NavigationView {
                List(astronauts, id: \.id) { astronaut in
            NavigationLink(destination: {
                Text(astronaut.name).navigationTitle(astronaut.name)
            }, label:{AstronautRow(astronaut: astronaut)}

            )
                }
                .navigationTitle("Astronauts")
            }
        }
       
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
