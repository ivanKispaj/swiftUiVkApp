//
//  GroupTableCell.swift
//  swiftUiVkApp
//
//  Created by Ivan Konishchev on 24.10.2022.
//

import SwiftUI


struct GroupTableCell: View {
    let rowHeight: CGFloat
    let color: Color
    let groupName: String
    let logo: Image
    
    init(groupName: String, logo: Data, rowHeight: CGFloat = 80, cellBackGround: Color = .gray)  {
        self.groupName = groupName
        if let image = UIImage(data: logo) {
            self.logo = Image(uiImage: image)
        } else {
            self.logo = Image(systemName: "image")
        }
        self.rowHeight = rowHeight
        self.color = cellBackGround
    }
    
    var body: some View {
        
        HStack {
            ImageAvatar(content: {
                logo
            })
            .padding(.leading, 10)
            Text(groupName)
                .padding(.leading,15)
            Spacer()
        }
        .frame(height: rowHeight)
        .background(Color.gray.opacity(0.2))
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

