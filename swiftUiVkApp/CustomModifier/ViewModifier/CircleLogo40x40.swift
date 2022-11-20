//
//  CircleLogo40x40.swift
//  swiftUiVkApp
//
//  Created by Ivan Konishchev on 20.11.2022.
//

import SwiftUI


struct CircleLogo40x40: ViewModifier {
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
    
    func circleLogo40x40(color: Color = .gray, offset: CGFloat = 4) -> some View {
        modifier(CircleLogo40x40(color: color, shadowOffset: offset))
    }
}
