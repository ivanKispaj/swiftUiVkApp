//
//  FriendsCellView.swift
//  swiftUiVkApp
//
//  Created by Ivan Konishchev on 24.10.2022.
//

import SwiftUI

struct FriendTableCell: View {
    let rowHeight: CGFloat
    let color: Color
    let friend: Friend
    let logo: Image
    @State var isSelected: Bool = false
    
    init(friend: Friend, rowHeight: CGFloat, cellBackGround: Color = .gray)  {
        self.friend = friend
        if let image = UIImage(data: friend.photo) {
            self.logo = Image(uiImage: image)
        } else {
            self.logo = Image(systemName: "image")
        }
        self.rowHeight = rowHeight
        self.color = cellBackGround
        
    }
    
    var body: some View {
        HStack(spacing: 0) {

                if let image = UIImage(data: self.friend.photo) {
                    ImageAvatar(content: {
                        Image(uiImage: image)
                    })
                    .padding(.leading,10)
                } else {
                    ImageAvatar(content: {
                        Image(systemName: "photo")
                    })
                    
                }
            VStack(alignment: .leading,spacing: 0) {
                    Text(friend.userName)
                HStack(spacing: 0) {
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
        .navigationDestination(isPresented: $isSelected) {
            EmptyView()
                .navigationTitle(friend.userName)
        }
        .onTapGesture {
            isSelected = true
        }
        .frame(height: rowHeight)
        .background(Color.gray.opacity(0.2))

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

