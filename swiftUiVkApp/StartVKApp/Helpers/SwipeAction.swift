//
//  SwipeAction.swift
//  swiftUiVkApp
//
//  Created by Ivan Konishchev on 11.11.2022.
//

import SwiftUI
import Combine

public typealias Leading<V> = Group<V> where V:View
public typealias Trailing<V> = Group<V> where V:View

public enum MenuType {
    case slided /// hstacked
    case swiped /// zstacked
}

public struct SwipeAction<V1: View, V2: View>: ViewModifier {

    enum VisibleButton {
        case none
        case left
        case right
    }

    @Binding private var isOnScreen: Int
    @Binding private var isSwiped: Bool
    @State private var offset: CGFloat = 0
    @State private var oldOffset: CGFloat = 0
    @State private var visibleButton: VisibleButton = .none
    
    @GestureState private var dragGestureActive: Bool = false
    
    @State private var maxLeadingOffset: CGFloat = .zero
    @State private var minTrailingOffset: CGFloat = .zero
    
    @State private var contentWidth: CGFloat = .zero
    @State private var isDeletedRow: Bool = false
    /**
     For lazy views: because of measuring size occurred every onAppear
     */
    @State private var maxLeadingOffsetIsCounted: Bool = false
    @State private var minTrailingOffsetIsCounted: Bool = false
    
    private let menuTyped: MenuType
    private let leadingSwipeView: Group<V1>?
    private let trailingSwipeView: Group<V2>?

    private let swipeColor: Color?
    private let allowsFullSwipe: Bool
    private let action: (() -> Void)?

    init(menu: MenuType, allowsFullSwipe: Bool = false, swipeColor: Color? = nil, isSwiped: Binding<Bool>, isOnScreen: Binding<Int>, @ViewBuilder _ content: @escaping () -> TupleView<(Leading<V1>, Trailing<V2>)>, action: (() -> Void)? = nil) {
        menuTyped = menu
        self.allowsFullSwipe = allowsFullSwipe
        self.swipeColor = swipeColor
        _isSwiped = isSwiped
        leadingSwipeView = content().value.0
        trailingSwipeView = content().value.1
        self.action = action
        _isOnScreen = isOnScreen
    }

    init(menu: MenuType, allowsFullSwipe: Bool = false, swipeColor: Color? = nil, isSwiped: Binding<Bool>, isOnScreen: Binding<Int>, @ViewBuilder leading: @escaping () -> V1, action: (() -> Void)? = nil) {
        menuTyped = menu
        self.allowsFullSwipe = allowsFullSwipe
        self.swipeColor = swipeColor
        _isSwiped = isSwiped
        leadingSwipeView = Group { leading() }
        trailingSwipeView = nil
        self.action = action
        _isOnScreen = isOnScreen
    }

    init(menu: MenuType, allowsFullSwipe: Bool = false, swipeColor: Color? = nil, isSwiped: Binding<Bool>, isOnScreen: Binding<Int>, @ViewBuilder trailing: @escaping () -> V2, action: (() -> Void)? = nil) {
        menuTyped = menu
        self.allowsFullSwipe = allowsFullSwipe
        self.swipeColor = swipeColor
        _isSwiped = isSwiped
        trailingSwipeView = Group { trailing() }
        leadingSwipeView = nil
        self.action = action
        _isOnScreen = isOnScreen
    }
    
    func reset() {
        visibleButton = .none
        offset = 0
        oldOffset = 0
    }
    
    var leadingView: some View {
        leadingSwipeView
            .measureSize {
                if !maxLeadingOffsetIsCounted {
                    maxLeadingOffset = maxLeadingOffset + $0.width + 20
                }
            }
            .onAppear {
                /**
                 maxLeadingOffsetIsCounted for of lazy views
                 */
                if #available(iOS 15, *) {
                    maxLeadingOffsetIsCounted = true
                }
            }
        
    }

    var trailingView: some View {
        trailingSwipeView
            .measureSize {
                if !minTrailingOffsetIsCounted {
                    minTrailingOffset = (abs(minTrailingOffset) + $0.width + 20) * -1
                }
            }
            .onAppear {
                /**
                 maxLeadingOffsetIsCounted for of lazy views
                 */
                if #available(iOS 15, *) {
                    minTrailingOffsetIsCounted = true
                }
            }
    }
    
    var swipedMenu: some View {
        HStack(spacing: 0) {
            leadingView
            Spacer()
            trailingView
                .offset(x: allowsFullSwipe && offset < minTrailingOffset ? (-1 * minTrailingOffset) + offset : 0)
        }
    }
    
    var slidedMenu: some View {
        HStack(spacing: 0) {
            leadingView
                .offset(x: (-1 * maxLeadingOffset) + offset)
            Spacer()
            trailingView
          
                .offset(x: (-1 * minTrailingOffset) + offset)
        }
    }
    
    func gesturedContent(content: Content) -> some View {
        content
            .contentShape(Rectangle()) ///otherwise swipe won't work in vacant area
            .offset(x: offset)
            .measureSize {
                contentWidth = $0.width
            }
            .gesture(
                DragGesture(minimumDistance: 15, coordinateSpace: .local)
                    .updating($dragGestureActive) { value, state, transaction in
                        state = true
                    }
                    .onChanged { value in
                        let totalSlide = value.translation.width + oldOffset
                        
                        if allowsFullSwipe && ...0 ~= Int(totalSlide) {
                            withAnimation {
                                offset = totalSlide
                            }
                        } else if (0 ... Int(maxLeadingOffset) ~= Int(totalSlide)) || (Int(minTrailingOffset) ... 0 ~= Int(totalSlide)) {
                            withAnimation {
                                offset = totalSlide
                            }
                        }

                    }
                    .onEnded { value in
                        print("gesture is ended!")
                     //   print(isSwiped)
                        withAnimation {
                            if visibleButton == .left && value.translation.width < -20 { ///user dismisses left buttons
                                isOnScreen = 0
                                reset()
                            } else if visibleButton == .right && value.translation.width > 20 { ///user dismisses right buttons
                                isOnScreen = 0
                                reset()
                            } else if offset > 20 || offset < -20 { ///scroller more then 50% show button
                             isOnScreen = 10
                                if offset > 0 {
                                    visibleButton = .left
                                    offset = maxLeadingOffset
                                } else {
                                    visibleButton = .right
                                    offset = minTrailingOffset
                                }
                                oldOffset = offset
                                ///Bonus Handling -> set action if user swipe more then x px
                            } else {
                                isOnScreen = 0
                                reset()
                            }
                        }

                        if allowsFullSwipe, value.translation.width < -(contentWidth * 0.7) {
                            withAnimation {
                                offset = -contentWidth
                            }
                            action?()
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
                                withAnimation {
                                    isDeletedRow = true
                                }
                            }
                        }
                    })
            .valueChanged(of: dragGestureActive) { newIsActiveValue in
                
                if isSwiped == false, newIsActiveValue {
                   
                    isSwiped = true
                    
                }
               
                if newIsActiveValue == false {
                    withAnimation {
                        if visibleButton == .none {
                          
                            reset()
                        }
                    }
                }
            }
            .valueChanged(of: isSwiped) { value in
                if value {
                    withAnimation {
                        reset()
                    }
                    isSwiped = false
                }
            }
    }
    
    public func body(content: Content) -> some View {
        switch menuTyped {
        case .slided:
            ZStack {
                swipeColor
                slidedMenu
                gesturedContent(content: content)
            }
            .frame(height: isDeletedRow ? 0 : nil, alignment: .top)
        case .swiped:
            ZStack {
                swipeColor
                swipedMenu
                gesturedContent(content: content)
            }
           .frame(height: isDeletedRow ? 0 : nil, alignment: .top)
        }
    }
}



extension View {
    /// A backwards compatible wrapper for iOS 14 `onChange`
    @ViewBuilder func valueChanged<T: Equatable>(of value: T, onChange: @escaping (T) -> Void) -> some View {
        if #available(iOS 14.0, *) {
            self.onChange(of: value, perform: onChange)
        } else {
            self.onReceive(Just(value)) { (value) in
                onChange(value)
            }
        }
    }
}


extension View {
    func measureSize(perform action: @escaping (CGSize) -> Void) -> some View {
        self.modifier(MeasureSizeModifier())
            .onPreferenceChange(SizePreferenceKey.self, perform: action)
    }
}

public extension View {
    
    @ViewBuilder
    func addSwipeAction<V1: View, V2: View>(menu: MenuType = .slided, isSwiped: Binding<Bool> = .constant(false), isOnScreen: Binding<Int> = .constant(0), @ViewBuilder _ content: @escaping () -> TupleView<(Leading<V1>, Trailing<V2>)>) -> some View {
        self.modifier(SwipeAction.init(menu: menu, isSwiped: isSwiped, isOnScreen: isOnScreen, content))
    }
    
    @ViewBuilder
    func addSwipeAction<V1: View>(menu: MenuType = .slided, edge: HorizontalAlignment, isSwiped: Binding<Bool> = .constant(false), isOnScreen: Binding<Int> = .constant(0), @ViewBuilder _ content: @escaping () -> V1) -> some View {
        switch edge {
        case .leading:
            self.modifier(SwipeAction<V1, EmptyView>.init(menu: menu, isSwiped: isSwiped, isOnScreen: isOnScreen, leading: content))
        default:
            self.modifier(SwipeAction<EmptyView, V1>.init(menu: menu, isSwiped: isSwiped, isOnScreen: isOnScreen, trailing: content))
        }
    }
    
    @ViewBuilder
    func addFullSwipeAction<V1: View, V2: View>(menu: MenuType = .slided,
                                                swipeColor: Color = Color.red,
                                                isSwiped: Binding<Bool> = .constant(false),
                                                isOnScreen: Binding<Int> = .constant(0),
                                                @ViewBuilder _ content: @escaping () -> TupleView<(Leading<V1>, Trailing<V2>)>,
                                                action: (() -> Void)? = nil) -> some View {
        self.modifier(SwipeAction.init(menu: menu, allowsFullSwipe: true, swipeColor: swipeColor, isSwiped: isSwiped, isOnScreen: isOnScreen, content, action: action))
    }
}


struct SizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}

struct MeasureSizeModifier: ViewModifier {
    func body(content: Content) -> some View {
        content.background(GeometryReader { geometry in
            Color.clear.preference(key: SizePreferenceKey.self,
                                   value: geometry.size)
        })
    }
}
