//
//  CircleShadow.swift
//  swiftUiVkApp
//
//  Created by Ivan Konishchev on 25.10.2022.
//

import SwiftUI

struct CircleShadow: ViewModifier {
    var color: Color
    var circleRadius: CGFloat = 50
    var shadowOffset: CGFloat
    
    func body(content: Content) -> some View {
        content
            .cornerRadius(circleRadius)
            .background(Circle()
                .fill(.white)
                .shadow(color: color, radius: shadowOffset)
            )
    }
}

extension View {
    
    func circleShadow(color: Color = .gray, offset: CGFloat = 4) -> some View {
        modifier(CircleShadow(color: color, shadowOffset: offset))
    }
}
