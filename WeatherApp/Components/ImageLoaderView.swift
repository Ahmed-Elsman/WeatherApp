//
//  ImageLoaderView.swift
//  WeatherApp
//
//  Created by Ahmed Elsman on 05/08/2024.
//

import SwiftUI

struct ImageLoaderView: View {
    var imageURL: URL
    var contentMode: ContentMode
    var body: some View {
        
        Rectangle()
            .opacity(0.0001)
            .overlay(
                AsyncImage(url: imageURL) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: contentMode)
                        .allowsHitTesting(false)
                } placeholder: {
                    ProgressView()
                }
                
            )
            .clipped()
    }
}

#Preview {
    ImageLoaderView(imageURL: URL(string: "https://picsum.photos/100/150")!,
                    contentMode: .fit)
        .frame(width: 60, height: 60)
        .cornerRadius(5)
}
