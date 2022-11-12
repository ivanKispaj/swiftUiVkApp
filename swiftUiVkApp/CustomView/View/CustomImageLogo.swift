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
    @State var isRotated: Bool = false
    init(@ViewBuilder content: () -> Image) {
        self.content = content()
    }
    
    var body: some View {
     
            content
                .frame(width: 40 ,height: 40)
                .modifier(CircleShadow(color: .blue, circleRadius: 50, shadowRadius: 8))
                .scaleEffect(isRotated ? 0.6 : 1)
                .onTapGesture {
                    isRotated.toggle()
                    withAnimation (.spring(response: 0.4,dampingFraction: 0.3)) {
                        isRotated.toggle()
                      
                    }
                }
    }
}
