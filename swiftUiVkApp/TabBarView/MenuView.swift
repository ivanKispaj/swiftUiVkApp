//
//  MenuView.swift
//  swiftUiVkApp
//
//  Created by Ivan Konishchev on 19.11.2022.
//

import Foundation
import SwiftUI

//struct MenuView: View {
//    @State var checked: Bool = false
//
//    var body: some View {
//        VStack(alignment: .leading) {
//            HStack {
//                Image(systemName: "door.left.hand.open")
//                    .foregroundColor(.gray)
//                    .imageScale(.large)
//                Text("Выйти")
//                    .foregroundColor(.gray)
//                    .font(.headline)
//            }
//            .padding(.top, 100)
//            HStack {
//                Image(systemName: "envelope")
//                    .foregroundColor(.gray)
//                    .imageScale(.large)
//
//                Toggle("FaceID: ", isOn: $checked)
//                    .onChange(of: checked) { newValue in
//                        self.checked = newValue
//                    }
//                    .foregroundColor(.gray)
//            }
//            .padding(.top, 30)
//            HStack {
//                Image(systemName: "gear")
//                    .foregroundColor(.gray)
//                    .imageScale(.large)
//                Text("Settings")
//                    .foregroundColor(.gray)
//                    .font(.headline)
//            }
//            .padding(.top, 30)
//            Spacer()
//        }
//        .padding()
//        .frame(maxWidth: .infinity, alignment: .leading)
//        .background(Color(red: 32/255, green: 32/255, blue: 32/255))
//        .edgesIgnoringSafeArea(.all)
//    }
//}




//struct SidebarMenu: View {
//    @Binding var isSidebarVisible: Bool
//    
//    var sideBarWidth = UIScreen.main.bounds.size.width * 0.7
//    
//    var userProfile: some View {
//        VStack(alignment: .leading) {
//            HStack {
//                AsyncImage(
//                    url: URL(
//                        string: "https://picsum.photos/100")) { image in
//                            image
//                                .resizable()
//                                .frame(width: 50, height: 50, alignment: .center)
//                                .clipShape(Circle())
//                                .overlay {
//                                    Circle().stroke(.blue, lineWidth: 2)
//                                }
//                        } placeholder: {
//                            ProgressView()
//                        }
//                        .aspectRatio(3 / 2, contentMode: .fill)
//                        .shadow(radius: 4)
//                        .padding(.trailing, 18)
//                
//                VStack(alignment: .leading, spacing: 6) {
//                    Text("John Doe")
//                        .foregroundColor(.white)
//                        .bold()
//                        .font(.title3)
//                    Text(verbatim: "john@doe.com")
//                        .foregroundColor(secondaryColor)
//                        .font(.caption)
//                }
//            }
//            .padding(.bottom, 20)
//        }
//    }
//    
//    var bgColor: Color =
//    Color(.init(
//        red: 52 / 255,
//        green: 70 / 255,
//        blue: 182 / 255,
//        alpha: 1))
//    
//
//    
//    var content: some View {
//        
//        HStack(alignment: .top) {
//            ZStack(alignment: .top) {
//                bgColor
//                MenuChevron
//                VStack(alignment: .leading, spacing: 20) {
//                    userProfile
//                    Divider()
//                    MenuLinks(items: userActions)
//                    Divider()
//                    MenuLinks(items: profileActions)
//                }
//                .padding(.top, 80)
//                .padding(.horizontal, 40)
//                
//            }
//            .frame(width: sideBarWidth)
//            .offset(x: isSidebarVisible ? 0 : -sideBarWidth)
//            .animation(.default, value: isSidebarVisible)
//            
//            Spacer()
//        }
//        
//    }
//    
//    struct MenuLink: View {
//        var secondaryColor: Color =
//        Color(.init(
//            red: 100 / 255,
//            green: 174 / 255,
//            blue: 255 / 255,
//            alpha: 1))
//        
//        var icon: String
//        var text: String
//        var body: some View {
//            HStack {
//                Image(systemName: icon)
//                    .resizable()
//                    .frame(width: 20, height: 20)
//                    .foregroundColor(secondaryColor)
//                    .padding(.trailing, 18)
//                Text(text)
//                    .foregroundColor(.white)
//                    .font(.body)
//            }
//            .onTapGesture {
//                print("Tapped on \(text)")
//            }
//        }
//    }
//    
//    struct MenuLinks: View {
//        var items: [MenuItem]
//        var body: some View {
//            VStack(alignment: .leading, spacing: 30) {
//                ForEach(items) { item in
//                    MenuLink(icon: item.icon, text: item.text)
//                }
//            }
//            .padding(.vertical, 14)
//            .padding(.leading, 8)
//        }
//    }
//    
//    
//    var MenuChevron: some View {
//        ZStack {
//            RoundedRectangle(cornerRadius: 18)
//                .fill(bgColor)
//                .frame(width: 60, height: 60)
//                .rotationEffect(Angle(degrees: 45))
//                .offset(x: isSidebarVisible ? -18 : -10)
//                .onTapGesture {
//                    isSidebarVisible.toggle()
//                }
//            
//            Image(systemName: "chevron.right")
//                .foregroundColor(secondaryColor)
//                .rotationEffect(
//                    isSidebarVisible ?
//                    Angle(degrees: 180) : Angle(degrees: 0))
//                .offset(x: isSidebarVisible ? -4 : 8)
//                .foregroundColor(.blue)
//        }
//        .offset(x: sideBarWidth / 2, y: 80)
//        .animation(.default, value: isSidebarVisible)
//    }
//    
//    var body: some View {
//        let drag = DragGesture()
//            .onEnded {
//                if $0.translation.width < -50 {
//                    withAnimation {
//                        self.isSidebarVisible = false
//                    }
//                }
//            }
//        
//        ZStack {
//            
//            GeometryReader { _ in
//                EmptyView()
//            }
//            .background(.black.opacity(0.6))
//            .opacity(isSidebarVisible ? 1 : 0)
//            .animation(.easeInOut.delay(0.2), value: isSidebarVisible)
//            .onTapGesture {
//                isSidebarVisible.toggle()
//            }
//            content
//                .gesture(drag)
//        }
//        
//        .edgesIgnoringSafeArea(.all)
//        
//    }
//}



