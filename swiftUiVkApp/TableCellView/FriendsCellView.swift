//
//  FriendsCellView.swift
//  swiftUiVkApp
//
//  Created by Ivan Konishchev on 24.10.2022.
//

import SwiftUI
import Combine

struct FriendsCellView: View {
    @State private var userName: String = "User Full Name"
    
    var body: some View {
        
        ScrollView {
            Group {
                FriendTableCell(userName: userName,logo: Image("VKlogo") , cellHeight: 70)
                FriendTableCell(userName: userName,logo: Image("VKlogo") , cellHeight: 70)
                FriendTableCell(userName: userName,logo: Image("VKlogo") , cellHeight: 70)
                FriendTableCell(userName: userName,logo: Image("VKlogo") , cellHeight: 70)
                FriendTableCell(userName: userName,logo: Image("VKlogo") , cellHeight: 70)
                FriendTableCell(userName: userName,logo: Image("VKlogo") , cellHeight: 70)
                FriendTableCell(userName: userName,logo: Image("VKlogo") , cellHeight: 70)
                FriendTableCell(userName: userName,logo: Image("VKlogo") , cellHeight: 70)
                
            }
        }
    }
    
}


struct FriendTableCell: View {
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
struct FriendsCell_Previews: PreviewProvider {
    
    static var previews: some View {
        
        FriendsCellView()
        
    }
}

