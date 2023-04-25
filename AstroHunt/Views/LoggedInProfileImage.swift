//
//  LoggedInProfileImage.swift
//  AstroHunt
//
//  Created by saood.akhtar on 25.04.23.
//

import SwiftUI
import NukeUI

struct LoggedInProfileImage: View {
    @StateObject var loginManager = AppLoginManager()

    var body: some View {
        HStack{
            LazyImage(url:  URL(string: loginManager.dpUrl)) { state in
                if let image = state.image {
                    image.resizable().aspectRatio(contentMode: .fill)
                } else if state.error != nil {
                    Color.red // Indicates an error
                } else {
                    LoadingView()
                }
            }
            .clipShape(Circle()).frame(width: 40, height: 40)
            .overlay {
                Circle().stroke(.white, lineWidth: 2)
            }
            .cornerRadius(8)
            .shadow(radius: 2)
            .frame(width: 40,height: 90).scaledToFit()
            Button(loginManager.isLoggedIn ?"Logout" :"Not logged in", action: {
                loginManager.logoutUser()
            })
        }
    }
}

struct LoggedInProfileImage_Previews: PreviewProvider {
    static var previews: some View {
        LoggedInProfileImage()
    }
}
