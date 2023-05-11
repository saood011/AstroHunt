//
//  SheetView.swift
//  AstroHunt
//
//  Created by saood.akhtar on 09.05.23.
//

import SwiftUI

struct SheetView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var loginManager = AppLoginManager()

    var body: some View {
        VStack{
            Text("Are you sure you want to log out?").font(.title3)
            Divider().padding(.bottom, 10)
            Button("Yes, Logout"){
                    loginManager.logoutUser()
                }
                .font(.callout)
                .foregroundColor(.white)
                .padding()
                .frame(width: 300)
                .background(.black)
                .cornerRadius(10)
            Button("Cancel") {
                    dismiss()
                }
                .font(.callout)
                .foregroundColor(.white)
                .padding()
                .frame(width: 300)
                .background(.gray)
                .cornerRadius(10)
               
        }
  
    }
}

struct SheetView_Previews: PreviewProvider {
    static var previews: some View {
        SheetView()
    }
}
