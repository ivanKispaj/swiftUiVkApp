//
//  CircleShadow.swift
//  swiftUiVkApp
//
//  Created by Ivan Konishchev on 25.10.2022.
//

import SwiftUI

struct CircleShadow: ViewModifier {
    var color: Color
    var circleRadius: CGFloat
    var shadowRadius: CGFloat
    
    func body(content: Content) -> some View {
        content
            .cornerRadius(circleRadius)
            .background(Circle()
                .fill(.white)
                .shadow(color: color, radius: shadowRadius)
            )
    }
}
