//
//  AstronautList.swift
//  AstroHunt
//
//  Created by saood.akhtar on 11.05.23.
//

import SwiftUI
import NukeUI

struct AstronautList: View {
    @EnvironmentObject var network: Network
    
    @StateObject var loginManager = AppLoginManager()
    
    var body: some View {
        NavigationView {
            List(network.astronauts) { astronaut in
                        NavigationLink {
                            DetailView(astronaut: astronaut)
                        } label: {
                            AstronautRow(astronaut: astronaut)
                        }
            }
            .navigationTitle("All Astronauts")
            .toolbar{
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    HStack{
                        LazyImage(url:  URL(string: loginManager.dpUrl)) { state in
                            if let image = state.image {
                                image.resizable().aspectRatio(contentMode: .fill)
                            } else if state.error != nil {
                                Color.red // Indicates an error
                            } else {
                                Color.blue // Acts as a placeholder
                            }
                        }
                        .clipShape(Circle()).frame(width: 40, height: 40)
                        .overlay {
                            Circle().stroke(.white, lineWidth: 2)
                        }
                        .cornerRadius(8)
                        .shadow(radius: 2)
                        .frame(width: 40,height: 90).scaledToFit()
                        Button("Logout", action: {
                            loginManager.logoutUser()
                        })
                    }
                   
                }
            }
            .listStyle(.inset)
                    .alert(isPresented: $network.error
                           , content: {
                        Alert(title: Text("Error Occured"), message: Text("too many requests, try after \(network.retryAfter) seconds"), dismissButton: .default(Text("Got it!")))
                    })
                }
        .onAppear {
            network.downloadApiRespnose()
        }
    }
}

struct AstronautList_Previews: PreviewProvider {
    static var previews: some View {
        AstronautList()
    }
}
