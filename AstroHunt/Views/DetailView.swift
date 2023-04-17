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
            ProfileImage(astronaut: astronaut)
            
            CircleImage(astronaut: astronaut)
            
            AstronautInfoText(astronaut: astronaut)
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

struct ProfileImage: View {
    var astronaut: Astronaut
    
    var body: some View {
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
    }
}


