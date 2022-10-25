//
//  GroupCell.swift
//  swiftUiVkApp
//
//  Created by Ivan Konishchev on 24.10.2022.
//

import SwiftUI

struct GroupCell: View {
    @State private var groupName: String = "Group Name"
    var body: some View {
        ScrollView {
            GroupTableCell(userName: "ВКонтакте", logo: Image("VKlogo"), cellHeight: 60)

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
struct GroupCell_Preview: PreviewProvider {
    
    static var previews: some View {
        
        GroupCell()
        
    }
}

