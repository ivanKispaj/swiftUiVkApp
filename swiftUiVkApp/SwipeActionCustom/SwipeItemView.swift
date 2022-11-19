//
//  SwipeItemView.swift
//  swiftUiVkApp
//
//  Created by Ivan Konishchev on 13.11.2022.
//

import Foundation
import SwiftUI

struct SwipeItemView: View {
    
    var swipeItems: [SwipeItem]
    var swipeItemsHeight: CGFloat
    @Binding var horizontalOffset: CGFloat
    
    var body: some View{
        HStack(spacing: 0) {
            ForEach(swipeItems) { swipeItem in
                VStack(spacing: 0) {
                    Spacer()
                    
                    if swipeItem.image() != nil{
                        swipeItem.image()!
                            .resizable()
                            .scaledToFit()
                            .frame(height: 20)
                            
                    }
                    swipeItem.label()!
                        .font(.footnote)
                    
                        
                    
                    Spacer()
                }
                
                .frame(width: swipeItem.itemWidth,height: swipeItemsHeight)
                .background(swipeItem.itemColor)
                .onTapGesture {
                    swipeItem.action()
                    withAnimation{
                        horizontalOffset = 0
                    }
                }
            }
        }
        .frame(height: swipeItemsHeight)
      
    }
}
