//
//  CustomImageLogo.swift
//  swiftUiVkApp
//
//  Created by Ivan Konishchev on 25.10.2022.
//

import SwiftUI

//MARK: logo View
struct  ImageAvatar: View {
    var content: Image
    @State var isRotated: Bool = false
    
    init(@ViewBuilder content: () -> Image) {
        self.content = content()
    }
    
    var body: some View {
     
            content
            .circleShadow()
                .scaleEffect(isRotated ? 0.6 : 1)
                .onTapGesture {
                    isRotated.toggle()
                    withAnimation (.spring(response: 0.4,dampingFraction: 0.3)) {
                        isRotated.toggle()
                      
                    }
                }
                
    }
}

struct  ImageAvatar1: View {
    var content: AsyncLoadAvatar
    @State var isRotated: Bool = false
    
    init(@ViewBuilder content: () -> AsyncLoadAvatar) {
        self.content = content()
    }
    
    var body: some View {
     
            content
            .circleShadow(color: .cyan,offset: 5)
                .scaleEffect(isRotated ? 0.6 : 1)
                .onTapGesture {
                    isRotated.toggle()
                    withAnimation (.spring(response: 0.4,dampingFraction: 0.3)) {
                        isRotated.toggle()
                      
                    }
                }
                
    }
}
