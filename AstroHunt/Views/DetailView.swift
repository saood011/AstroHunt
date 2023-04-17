//
//  DetailView.swift
//  AstroHunt
//
//  Created by saood.akhtar on 16.04.23.
//

import SwiftUI

struct DetailView: View {
    @EnvironmentObject var network: Network

    
    let astronaut : Astronaut
    
    var body: some View {
        ScrollView() {
            AsyncImage(url: URL(string: astronaut.profileImage)){
                phase in
                switch phase{
                case .empty: ProgressView()
                case .success(let image): image.resizable().frame(maxWidth: 400, maxHeight: 480).scaledToFit().shadow(radius: 10)
                case .failure: Image(systemName: "wifi.slash")
                @unknown default:
                    EmptyView()
                }
                
            }
            .frame(height: 500)
            
            
            CircleImage(astronaut: astronaut)
                .offset(y: -80).padding(.bottom, -130)
            
            
            VStack(alignment: .leading) {
      
                Text(astronaut.name)
                    .font(.title)
                
                Text(astronaut.nationality).padding(.leading, 4.0)
                
                
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Divider()
                
                Text("About").padding(.vertical)
                    .font(.title2)
                Text(astronaut.bio).italic()
                    ForEach(network.astronautFlights){
                        flight in
                        Text(flight.name).clipShape(Rectangle()).padding().background(.gray).cornerRadius(8)
                    }
            }
            .padding()
            Spacer()
        }
        .navigationTitle(astronaut.name)
            .navigationBarTitleDisplayMode(.inline)
            .onAppear{
                   network.getAstronautDetails(id:String(astronaut.id))
        }
        
    }
}



struct DetailView_Previews: PreviewProvider {
    
    static var previews: some View {
        DetailView(astronaut: MockData.sampleAstronaut).environmentObject(Network())
    }
}
