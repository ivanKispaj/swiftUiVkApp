//
//  CustomImageLogo.swift
//  swiftUiVkApp
//
//  Created by Ivan Konishchev on 25.10.2022.
//

import SwiftUI

//MARK: logo View
struct  CustomImageLogo: View {
    var content: Image
    
    init(@ViewBuilder content: () -> Image) {
        self.content = content()
    }
    
    var body: some View {
        content
            .resizable()
            .frame(width: 50,height: 50)
            .modifier(CircleShadow(color: .red, circleRadius: 50, shadowRadius: 8))
    }
}
