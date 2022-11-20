//
//  AsyncLoadAvatar.swift
//  swiftUiVkApp
//
//  Created by Ivan Konishchev on 20.11.2022.
//

import SwiftUI

struct  AsyncLoadAvatar: View {
   // var content: Image
    private var url: String
    private var size: CGFloat
    
    init(url: String, size: CGFloat = 40) {
        self.url = url
        self.size = size
    }
    
    var body: some View {
        if let url = URL(string: self.url) {
            AsyncImage(url: url) { image in
                image
                    .resizable()
                    .frame(width: size, height: size, alignment: .center)
            } placeholder: {
                ProgressView()
            }
        } else {
            Image(systemName: "photo")
        }
    }
}
