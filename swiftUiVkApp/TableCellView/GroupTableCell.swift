//
//  GroupTableCell.swift
//  swiftUiVkApp
//
//  Created by Ivan Konishchev on 24.10.2022.
//

import SwiftUI


struct GroupTableCell: View {
    let cellHeight: CGFloat
    let color: Color
    let groupName: String
    let logo: Image
    
    init(groupName: String, logo: Data, cellHeight: CGFloat = 80, cellBackGround: Color = .gray)  {
        self.groupName = groupName
        if let image = UIImage(data: logo) {
            self.logo = Image(uiImage: image)
        } else {
            self.logo = Image(systemName: "image")
        }
        self.cellHeight = cellHeight
        self.color = cellBackGround
    }
    
    var body: some View {
        
        HStack {
            CustomImageLogo(content: {
                logo
            })
            .frame(minHeight: cellHeight)
           // .padding(.leading, 20)
            Text(groupName)
                .padding(.leading,15)
            Spacer()
        }
        .listRowBackground(
                            RoundedRectangle(cornerRadius: 5)
                                .background(.clear)
                                .foregroundColor(.gray.opacity(0.2))
                                .padding(
                                    EdgeInsets(
                                        top: 2,
                                        leading: 0,
                                        bottom: 2,
                                        trailing: 0
                                    )
                                )
                        )
                        .listRowSeparator(.hidden)
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

