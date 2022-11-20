//
//  SidebarMenu.swift
//  swiftUiVkApp
//
//  Created by Ivan Konishchev on 20.11.2022.
//

import SwiftUI

struct SidebarMenu: View {
    
    @Binding var isSidebarVisible: Bool
    
    var sideBarModel: SideBarViewModel = SideBarViewModel()
    
    var sideBarWidth = UIScreen.main.bounds.size.width * 0.7 // Ширина sideBar
    
    var userProfile: some View {
        
        VStack(alignment: .leading) {
            
            HStack {
                
                AsyncLoadAvatar(url: "https://picsum.photos/100",size: 50)
                    .clipShape(Circle())
                    .overlay {
                        Circle().stroke(.blue, lineWidth: 2)
                    }
                    .aspectRatio(3 / 2, contentMode: .fill)
                    .shadow(radius: 4)
                    .padding(.trailing, 18)
                
                VStack(alignment: .leading, spacing: 6) {
                    
                    Text("John Doe")
                        .foregroundColor(.white)
                        .bold()
                        .font(.title3)
                    Text(verbatim: "john@doe.com")
                        .foregroundColor(sideBarModel.secondaryColor)
                        .font(.caption)
                }
            }
            .padding(.bottom, 20)
        }
        
    }
    
    var content: some View {
        
        HStack(alignment: .top) {
            ZStack(alignment: .top) {
                sideBarModel.bgColor
                MenuChevron
                VStack(alignment: .leading, spacing: 20) {
                    userProfile
                    Divider()
                        .background(Color.white)
                    MenuLinks(items: sideBarModel.userActions)
                    Divider()
                        .background(Color.white)
                    MenuLinks(items: sideBarModel.profileActions)
                }
                .padding(.top, 80)
                .padding(.horizontal, 40)
                
            }
            .frame(width: sideBarWidth)
            .offset(x: isSidebarVisible ? 0 : -sideBarWidth)
            .animation(.default, value: isSidebarVisible)
            
            Spacer()
        }
        
    }
    
    var MenuChevron: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 18)
                .fill(sideBarModel.bgColor)
                .frame(width: 60, height: 60)
                .rotationEffect(Angle(degrees: 45))
                .offset(x: isSidebarVisible ? -18 : -5)
                .onTapGesture {
                    isSidebarVisible.toggle()
                }
            
            Image(systemName: "chevron.right")
                .foregroundColor(sideBarModel.secondaryColor)
                .rotationEffect(
                    isSidebarVisible ?
                    Angle(degrees: 180) : Angle(degrees: 0))
                .offset(x: isSidebarVisible ? -4 : 8)
                .foregroundColor(.blue)
        }
        .offset(x: sideBarWidth / 2, y: 80)
        .animation(.default, value: isSidebarVisible)
    }
    
    var body: some View {
        let drag = DragGesture()
            .onEnded {
                if $0.translation.width < -50 {
                    withAnimation {
                        self.isSidebarVisible = false
                    }
                }
            }
        
        ZStack {
            
            GeometryReader { _ in
                EmptyView()
            }
            .background(.black.opacity(0.6))
            .opacity(isSidebarVisible ? 1 : 0)
            .animation(.easeInOut.delay(0.2), value: isSidebarVisible)
            .onTapGesture {
                isSidebarVisible.toggle()
            }
            content
                .gesture(drag)
        }
        .edgesIgnoringSafeArea(.all)
        
    }
    
}
