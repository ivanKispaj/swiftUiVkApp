//
//  FriendsCellView.swift
//  swiftUiVkApp
//
//  Created by Ivan Konishchev on 24.10.2022.
//

import SwiftUI
import Combine
import Kingfisher
struct FriendsCellView: View {
    @State private var userName: String = "User Full Name"
    @State var friends: Friend
    @State var isSelected = false
    var body: some View {

        ScrollView {
            FriendTableCell(userName: friends.userName, logo:   Image(uiImage: (UIImage(data: friends.photo) ?? UIImage(systemName: "photo"))!) )
                
                .navigationDestination(isPresented: $isSelected) {
                 //   GroupCell(group: friends)
                    EmptyView()
                }
                .onTapGesture {
                    self.isSelected = true
                }
        }
    }
    
}


struct FriendTableCell: View {
    let cellHeight: CGFloat
    let color: Color
    let userName: String
    let logo: Image
    
    init(userName: String, logo: Image, cellHeight: CGFloat = 60, cellBackGround: Color = .gray)  {
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
                .padding(.leading, 20)
         
          
            Text(userName)
                .padding(.leading,15)
            Spacer()
        }
        .frame(height: cellHeight)
        .background(color.opacity(0.3))
        .border(.blue,width: 1)
        .cornerRadius(3)
    }
}




//// Для превью FriendsCell
//struct FriendsCell_Previews: PreviewProvider {
//    
//    static var previews: some View {
//        
//     //   FriendsCellView()
//        
//    }
//}

