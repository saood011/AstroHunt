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
    @State private var showingSheet = false

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
          
                
                    }
                    Button(action: {
                        showingSheet.toggle()
                    }, label: {
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
                    })
                        .sheet(isPresented: $showingSheet) {
                            SheetView().presentationDetents([.height(200)])
                        }
                }
            }
            .listStyle(.inset)
                }
        .onAppear {
            network.downloadApiRespnose()
        }
    }
}

struct AstronautList_Previews: PreviewProvider {
    static var previews: some View {
        AstronautList().environmentObject(Network())
    }
}
