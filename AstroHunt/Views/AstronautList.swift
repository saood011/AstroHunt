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
                    Button(action: {
                            showingSheet.toggle()
                        }, label: {
                            LoggedInProfileImage()
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
