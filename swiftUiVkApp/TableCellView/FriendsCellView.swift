//
//  FriendsCellView.swift
//  swiftUiVkApp
//
//  Created by Ivan Konishchev on 24.10.2022.
//

import SwiftUI

struct FriendTableCell: View {
    let cellHeight: CGFloat
    let color: Color
    let friend: Friend
    let logo: Image
    @State var isSelected: Bool = false
    
    init(friend: Friend, cellHeight: CGFloat = 50, cellBackGround: Color = .gray)  {
        self.friend = friend
        if let image = UIImage(data: friend.photo) {
            self.logo = Image(uiImage: image)
        } else {
            self.logo = Image(systemName: "image")
        }
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
        .navigationDestination(isPresented: $isSelected) {
            EmptyView()
                .navigationTitle(friend.userName)
        }
        .onTapGesture {
            isSelected = true
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

