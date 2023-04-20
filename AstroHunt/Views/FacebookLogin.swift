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
                VStack{
                    Text("Welcome to AstroHunt!").background(Image("astro"))
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
                    })
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
