//
//  ContentView.swift
//  AstroHunt
//
//  Created by saood.akhtar on 14.04.23.
//
import SwiftUI

struct ContentView: View {
    @EnvironmentObject var network: Network

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
                    .listStyle(.grouped)
                    .alert(isPresented: $network.error
                           , content: {
                        Alert(title: Text("Error Occured"), message: Text("too many requests, try after \(network.retryAfter) seconds"), dismissButton: .default(Text("Got it!")))
                    })
                }
        .onAppear {
            network.downloadApiRespnose()
        }
        if network.isLoading{
            LoadingView()
        }
      
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(Network())
    }
}

struct AstronautRow2: View {
    
    let astronaut: Astronaut
    
    var body: some View {
        HStack(alignment:.top) {
            AsyncImage(url: URL(string: astronaut.profileImageThumbnail))
                .aspectRatio(contentMode: .fit)
                .frame(width: 120, height: 90)
                .cornerRadius(8)
            VStack(alignment: .leading) {
                Spacer()
                Text(astronaut.name).bold()
                Text("Age: \(String(astronaut.age))")
                Spacer()
            }
        }
        .frame(width: 330, alignment: .leading)
        .padding()
        .background(Color(#colorLiteral(red: 0.6667672396, green: 0.7527905703, blue: 1, alpha: 0.2662717301)))
        .cornerRadius(20)
    }
}


