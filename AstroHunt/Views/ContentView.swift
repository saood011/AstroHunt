//
//  ContentView.swift
//  AstroHunt
//
//  Created by saood.akhtar on 14.04.23.
//
import SwiftUI
import NukeUI

struct ContentView: View {
    
    @EnvironmentObject var network: Network
    
    @StateObject var loginManager = AppLoginManager()

    var body: some View {
     
        ZStack{
            if !loginManager.isLoggedIn{
                CoverView()
            }else{
                AstronautTabView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(Network())
    }
}



