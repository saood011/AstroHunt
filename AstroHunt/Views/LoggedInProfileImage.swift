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
            .frame(width: 35, height: 35)
            .overlay {
                Circle()
                .stroke(.white, lineWidth: 2)
            }
            .cornerRadius(8)
            .shadow(radius: 2)
            .frame(width: 40,height: 90)
            .scaledToFit()
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
