//
//  FacebookLogin.swift
//  AstroHunt
//
//  Created by saood.akhtar on 19.04.23.
//

import Foundation

import SwiftUI
import FacebookLogin

struct CoverView: View {

 @StateObject var loginManager = FacebookLoginManager()
    
    var body: some View {
        
        ZStack{
            if loginManager.isLoggedIn{
                ContentView()
                
            }else{
                ZStack{
                    Image("astro").resizable().aspectRatio(contentMode: .fill).ignoresSafeArea(.all)
                    Text("Welcome to AstroHunt").font(.title).padding(.all).background(.black.opacity(0.5)).foregroundColor(.white).cornerRadius(10)

                        Button(action: {
                            if loginManager.isLoggedIn{
                                loginManager.logoutUser()
                            }else{
                                loginManager.loginUser()
                            }
                        }, label: {
                            Text(loginManager.isLoggedIn ? "Logout": "Login with facebook ")
                                .fontWeight(.bold)
                                .padding(.vertical, -10)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.blue)
                        }).padding()
                    .foregroundColor(.white).frame(height: 40).background(.white.opacity(0.5)).cornerRadius(10).padding(.top, 500)
                }
            }
        }.transition(.slide)
            .animation(.easeInOut)
    }
}


struct CoverView_Previews: PreviewProvider {
    static var previews: some View {
        CoverView()
    }
}

