//
//  AstronautInfoText.swift
//  AstroHunt
//
//  Created by saood.akhtar on 17.04.23.
//

import SwiftUI

struct AstronautInfoText: View {
    let astronaut: Astronaut
    @EnvironmentObject var network: Network

    var body: some View {
        VStack(alignment: .leading) {
            
            Text(astronaut.name)
                .font(.title)
            Text(astronaut.nationality)
                .padding(.leading, 4.0)
                .font(.subheadline)
                .foregroundColor(.secondary)
            Divider()
            HStack {
                Image(systemName: "person.text.rectangle")
                Text("About").padding(.vertical)
                    .font(.title2)
            }
            Text(astronaut.bio).italic()
            Divider()
            HStack {
                Image(systemName: "airplane")
                Text("Flights").padding(.vertical).font(.title2)
            }
            ForEach(network.astronautFlights){
                flight in
                Text(flight.name).clipShape(Rectangle()).padding().background(.cyan).cornerRadius(8)
            }
        }
        .padding()
    }
}

struct AstronautInfoText_Previews: PreviewProvider {
    static var previews: some View {
        AstronautInfoText(astronaut: MockData.sampleAstronaut).environmentObject(Network())
    }
}
