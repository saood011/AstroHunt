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

 @StateObject var loginManager = AppLoginManager()
    
    var body: some View {
                ZStack{
                    Image("astro").resizable().aspectRatio(contentMode: .fill).ignoresSafeArea(.all)
                    HStack {
                        Text("AstroHunt").frame(width: 600, height: 70).font(.largeTitle).padding(.all).background(.white
                        ).foregroundColor(.black)
                            .cornerRadius(5).padding(.bottom, 400)
                    }
                    Button(action: {
                                loginManager.loginUser()
                        }, label: {
                            Text("Login with facebook")
                                .fontWeight(.bold)
                                .padding(.vertical, -10)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.blue)
                        }).padding(.horizontal, 5).shadow(radius: 5).padding(.top, 500)
                    Button(action: {
                        loginManager.FaceIdLogin()
                        }, label: {
                            VStack {
                                Image(systemName: "faceid").resizable().frame(width: 50,height: 50).foregroundColor(.white)
                                Text("Login with FaceID")
                                    .fontWeight(.bold)
                                    .padding(.vertical, -10)
                                    .foregroundColor(.white)
                                    .padding()
                            }
                        }).padding(.horizontal, 5).padding(.top, 300)

        }.transition(.slide)
            .animation(.easeInOut)
    }
}


struct CoverView_Previews: PreviewProvider {
    static var previews: some View {
        CoverView()
    }
}

