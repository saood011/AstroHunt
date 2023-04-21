//
//  DetailView.swift
//  AstroHunt
//
//  Created by saood.akhtar on 16.04.23.
//

import SwiftUI
import NukeUI

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
    @StateObject var loginManager = FacebookLoginManager()
    
    var body: some View {
        LazyImage(url:  URL(string: astronaut.profileImage)) { state in
            if let image = state.image {
                image.resizable().aspectRatio(contentMode: .fit)
         
            } else if state.error != nil {
                Color.red // Indicates an error
            } else {
                ProgressView()
            }
        }
        .frame(height: 500)

        Button {
            loginManager.shareImageViaFacebook(url: URL(string: astronaut.profileImageThumbnail)!)
        } label: {
            Label("Share", systemImage: "square.and.arrow.up")
        }.zIndex(2).padding(.leading, 300)
    }
}


