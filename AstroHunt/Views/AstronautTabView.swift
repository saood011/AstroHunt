//
//  TabView.swift
//  AstroHunt
//
//  Created by saood.akhtar on 02.05.23.
//

import SwiftUI

struct AstronautTabView: View {
    @EnvironmentObject var network: Network

    var body: some View {

            TabView{
                AstronautList().tabItem {
                    Label("List View", systemImage: "list.bullet")
                }
                AstronautCardView(astronauts: network.astronauts)
                     .tabItem {
                         Label("Card View", systemImage: "menucard")
                     }
            }
    }
}

struct AstronautTabView_Previews: PreviewProvider {
    static var previews: some View {
        AstronautTabView().environmentObject(Network())
    }
}
