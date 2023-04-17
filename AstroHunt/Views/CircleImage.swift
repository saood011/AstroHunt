//
//  CircleImage.swift
//  AstroHunt
//
//  Created by saood.akhtar on 17.04.23.
//

import SwiftUI

struct CircleImage: View {
    let astronaut: Astronaut
    var body: some View {
        AsyncImage(
            url: URL(string: astronaut.agency.logoUrl),
            transaction: Transaction(animation: .easeInOut)
        ) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image
                    .resizable()
                    .transition(.scale(scale: 0.1, anchor: .center)).scaledToFit()
            case .failure:
                Image(systemName: "wifi.slash")
            @unknown default:
                EmptyView()
            }
        }
        .frame(width: 100, height: 100)
        .background(Color.white)
        .clipShape(Circle())
        .overlay {
            Circle().stroke(.white, lineWidth: 4)
        }.shadow(radius: 9)
    }
}
