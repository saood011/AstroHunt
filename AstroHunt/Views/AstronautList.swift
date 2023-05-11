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
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                            showingSheet.toggle()
                        }, label: {
                            LoggedInProfileImage()
                        })
                        .sheet(isPresented: $showingSheet) {
                            SheetView().presentationDetents([.height(200)])
                        }
                }
                ToolbarItem(placement: .navigationBarLeading){
                    Menu {
                        Button {
                            withAnimation(.default){
                                network.sortByAge()
                            }
                        } label: {
                            Text("Sort by age")
                            Image(systemName: "arrow.down.right.circle")
                        }
                        Button {
                            withAnimation(.default){
                                network.sortByName()
                            }
                        } label: {
                            Text("Sort by name")
                            Image(systemName: "arrow.up.and.down.circle")
                        }
                    } label: {
                         Image(systemName: "line.3.horizontal.decrease")
                    }                }
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
