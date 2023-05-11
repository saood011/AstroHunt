//
//  ProcessedImage.swift
//  AstroHunt
//
//  Created by saood.akhtar on 19.04.23.
//

import SwiftUI
import NukeUI

struct RectangleImage: View {
    let url: URL
    var body: some View {
        LazyImage(url:  url) { state in
            if let image = state.image {
                image.resizable().aspectRatio(contentMode: .fill)
            } else if state.error != nil {
                Color.red // Indicates an error
            } else {
                Color.blue // Acts as a placeholder
            }
        }
        .clipShape(Rectangle()).frame(width: 100, height: 100)
        .cornerRadius(18)
        .overlay {
            Rectangle().stroke(.white, lineWidth: 8)
        }
        .cornerRadius(8)
        .shadow(radius: 7)
        .frame(width: 120,height: 90).scaledToFit()
    }
}


struct ProcessedImage_Previews: PreviewProvider {
    static var previews: some View {
        RectangleImage(url: URL(string:(MockData.sampleAstronaut.profileImageThumbnail))!)
    }
}
