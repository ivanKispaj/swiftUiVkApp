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
    @State var friend: Friend
    @State var isSelected = false
    var body: some View {


            FriendTableCell(friend: friend)
                .navigationDestination(isPresented: $isSelected) {
                 //   GroupCell(group: friends)
                    EmptyView()
                        .navigationTitle(friend.userName)
                }

                .onTapGesture {
                    self.isSelected = true
                }
    }
    
}


struct FriendTableCell: View {
    let cellHeight: CGFloat
    let color: Color
    let friend: Friend
    let logo: Image = Image(systemName: "photo")

    @State var isScaled: Bool = false
    
    init(friend: Friend, cellHeight: CGFloat = 50, cellBackGround: Color = .gray)  {
        self.friend = friend
        self.cellHeight = cellHeight
        self.color = cellBackGround
        
    }
    
    var body: some View {
        HStack {
            VStack {
            
                if let image = UIImage(data: self.friend.photo) {
                    CustomImageLogo(content: {
                        Image(uiImage: image)
                           
                            
                    })
                } else {
                    CustomImageLogo(content: {
                        Image(systemName: "photo")
                    })
                    .scaleEffect(isScaled ? 0.01 : 1)
                    
                }
            }
           
           
          
            VStack(alignment: .leading) {
                    Text(friend.userName)
                HStack {
                    Text(friend.city)
                        .font(.subheadline)
                        .fontWeight(.ultraLight)
                    Spacer()
                    if friend.isBanned {
                        Text("Banned")
                            .fontWeight(.heavy)
                            .font(.footnote)
                            .foregroundColor(.pink)
                    } else if friend.isClosedProfile {
                        Text("Private")
                            .fontWeight(.heavy)
                            .font(.footnote)
                            .foregroundColor(.red)
                    } 
                    
                }
            }
                .padding(.leading, 15)
            
            Spacer()
        }
      
        .frame(height: cellHeight)

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

