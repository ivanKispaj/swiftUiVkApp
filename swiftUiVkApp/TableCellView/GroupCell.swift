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
        groupCell
    }
    
}

private extension GroupCell {
    var groupCell: some View {
        VStack {
            GeometryReader { _ in
                
                HStack {
                    
                    Image("VKlogo")
                        .resizable()
                        .frame(width: 50,height: 50)
                        .background(Color.white)
                        .cornerRadius(50)
                        .shadow(color: .cyan, radius: 8)
                    Text(groupName)
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
struct GroupCell_Preview: PreviewProvider {
    
    static var previews: some View {
        
        GroupCell()
        
    }
}

