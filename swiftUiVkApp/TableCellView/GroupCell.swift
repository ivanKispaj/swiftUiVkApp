//
//  GroupCell.swift
//  swiftUiVkApp
//
//  Created by Ivan Konishchev on 24.10.2022.
//

import SwiftUI

struct GroupCell: View {
    @State private var groupName: String = "Group Name"
 //   @State var group: Friends = Friends(name: "Путин", imageName: "flag.2.crossed")
    @State private var isPresented = false
    
    var body: some View {
        ScrollView {
//            GroupTableCell(userName: group.name, logo: Image(systemName: group.imageName), cellHeight: 60)
//                .navigationDestination(isPresented: $isPresented) {
//                    FriendsCellView(friends: group)
//                }
//                .onTapGesture {
//                    self.isPresented = true
//                }
        }
    }
    
}


struct GroupTableCell: View {
    let cellHeight: CGFloat
    let color: Color
    let userName: String
    let logo: Image
    
    init(userName: String, logo: Image, cellHeight: CGFloat = 80, cellBackGround: Color = .gray)  {
        self.userName = userName
        self.logo = logo
        self.cellHeight = cellHeight
        self.color = cellBackGround
    }
    
    var body: some View {
        
        HStack(alignment: .center) {
            CustomImageLogo(content: {
                logo
            })
            .frame(minHeight: cellHeight)
            .padding(.leading, 20)
            Text(userName)
                .padding(.leading,15)
            Spacer()
        }
        .background(color.opacity(0.3))
    }
}

// Для превью FriendsCell
//struct GroupCell_Preview: PreviewProvider {
//    
//    static var previews: some View {
//        
//        GroupCell()
//        
//    }
//}

