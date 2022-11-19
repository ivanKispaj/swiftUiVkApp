//
//  SwipeActions.swift
//  swiftUiVkApp
//
//  Created by Ivan Konishchev on 13.11.2022.
//

import Foundation
import SwiftUI

struct SwipeActions: ViewModifier {
    
    private var leadingSwipeItems: [SwipeItem]
    private var trailingSwipeitems: [SwipeItem]
    private var rowHeight: CGFloat
    
    @State private var centralContentOffset: CGFloat = 0
    @State private var offsetOnSwipe: CGFloat = 0
    @State private var isOnscreen: Bool = false
    private var isLeftSwipe: Bool {
        offsetOnSwipe > 0 ?
            centralContentOffset > showSwipeItemsOnScreenValue - swipeRecognitionValue
            :
            centralContentOffset > swipeRecognitionValue
    }
    
    private var isRightSwipe: Bool {
        offsetOnSwipe < 0 ?
            centralContentOffset < -showSwipeItemsOnScreenValue + swipeRecognitionValue
            :
            centralContentOffset < -swipeRecognitionValue
    }
    
    let screenWidth = UIScreen.main.bounds.width
    private var showSwipeItemsOnScreenValue: CGFloat { screenWidth / 3 }
    private var swipeRecognitionValue: CGFloat { screenWidth / 15 }
    
    private func swipeItemsArrayWidth(for array: [SwipeItem]) -> CGFloat {
        array.map { $0.itemWidth}.reduce(0, +)
    }
    
    init (leading: [SwipeItem], trailing: [SwipeItem], rowHeight: CGFloat) {
        leadingSwipeItems = leading
        trailingSwipeitems = trailing
        self.rowHeight = rowHeight
    }
    
    func body(content: Content) -> some View {
        
            GeometryReader { geo in
                HStack(spacing: 0) {
                    SwipeItemView(swipeItems: leadingSwipeItems,
                                  swipeItemsHeight: rowHeight,
                                  horizontalOffset: $centralContentOffset)
                      
                    content
                        .frame(width: geo.size.width)
                    
                    SwipeItemView(swipeItems: trailingSwipeitems,
                                  swipeItemsHeight: rowHeight,
                                  horizontalOffset: $centralContentOffset)
                }
            }
            .offset(x: -swipeItemsArrayWidth(for: leadingSwipeItems) + centralContentOffset)
            .frame(height: rowHeight)
            .contentShape(Rectangle())
            .gesture(dragGesture)
            .clipped()
    }
    
    private var dragGesture: some Gesture {
        DragGesture(minimumDistance: 30, coordinateSpace: .local)
            .onChanged { value in
                withAnimation {
                    
                    if !leadingSwipeItems.isEmpty && value.translation.width > 0 {
                    centralContentOffset = offsetOnSwipe + value.translation.width
                    }
                    
                    if !trailingSwipeitems.isEmpty && value.translation.width < 0 {
                    centralContentOffset = offsetOnSwipe + value.translation.width
                    }
          
                    if abs(centralContentOffset) > showSwipeItemsOnScreenValue {
                        centralContentOffset = isLeftSwipe ? showSwipeItemsOnScreenValue : -showSwipeItemsOnScreenValue
                    }
                }
            }
            .onEnded { value in
                withAnimation {
                    if isRightSwipe {
                        if self.isOnscreen {
                            self.isOnscreen = false
                            offsetOnSwipe = 0
                        } else {
                            self.isOnscreen = true
                            offsetOnSwipe = -swipeItemsArrayWidth(for: trailingSwipeitems)
                        }
                       
                    } else if isLeftSwipe {
                        if self.isOnscreen {
                            self.isOnscreen = false
                            offsetOnSwipe = 0
                        } else {
                            self.isOnscreen = true
                            offsetOnSwipe = swipeItemsArrayWidth(for: leadingSwipeItems)
                        }
                    } else {
                        isOnscreen = false
                        offsetOnSwipe = 0
                    }
                    centralContentOffset = offsetOnSwipe
                }
            }
    }
}

extension View {
    func swipeAction(leading: [SwipeItem] = [], trailing: [SwipeItem] = [], rowHeight: CGFloat) -> some View {
        return modifier(SwipeActions(leading: leading, trailing: trailing, rowHeight: rowHeight))
    }
}
