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
    @State private var showSheet = false

    var body: some View {
        HStack{
            Button(action:{
                showSheet.toggle()
            }, label: {
                LazyImage(url:  URL(string: loginManager.dpUrl)) {
                state in
                if let image = state.image {
                    image.resizable()
                        .aspectRatio(contentMode: .fill)
                } else if state.error != nil {
                    Color.red // Indicates an error
                } else {
                    LoadingView()
                }
                }
            .clipShape(Circle())
            .frame(width: 40, height: 40)
            .overlay {
                Circle()
                .stroke(.white, lineWidth: 1)
            }
            .cornerRadius(8)
            .shadow(radius: 2)
            .scaledToFit()
                Text(loginManager.name != "" ? loginManager.name.split(separator: " ")[0] : "User")
            })
            .sheet(isPresented: $showSheet) {
                SheetView().presentationDetents([.fraction(0.3)])
            }
            }
    }
}

struct LoggedInProfileImage_Previews: PreviewProvider {
    static var previews: some View {
        LoggedInProfileImage()
    }
}
