//
//  AstroHuntApp.swift
//  AstroHunt
//
//  Created by saood.akhtar on 14.04.23.
//

import SwiftUI

@main
struct AstroHuntApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate


    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(Network())
        }
    }
}
