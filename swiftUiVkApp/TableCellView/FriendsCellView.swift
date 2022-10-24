//
//  FriendsCellView.swift
//  swiftUiVkApp
//
//  Created by Ivan Konishchev on 24.10.2022.
//

import SwiftUI

struct FriendsCellView: View {
    
    @State private var userName: String = "User Full Name"
    var body: some View {
        friensCell
    }
    
}

private extension FriendsCellView {
    var friensCell: some View {
        VStack {
            GeometryReader { _ in
                
                HStack {
                    
                    Image("VKlogo")
                        .resizable()
                        .frame(width: 50,height: 50)
                        .background(Color.white)
                        .cornerRadius(50)
                        .shadow(color: .cyan, radius: 5)
                    Text(userName)
                        .padding(.leading, 20)
                }
                
                .padding(20)
            }
            
            
        }
        .background(Color.gray.opacity(0.3))
        
        .frame(height: 80)
    }
}

// Для превью FriendsCell
struct FriendsCell_Previews: PreviewProvider {
    
    static var previews: some View {
        
        FriendsCellView()
        
    }
}
