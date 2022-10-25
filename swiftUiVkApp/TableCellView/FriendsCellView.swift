//
//  FriendsCellView.swift
//  swiftUiVkApp
//
//  Created by Ivan Konishchev on 24.10.2022.
//

import SwiftUI
import Combine

struct FriendsCellView: View {
    var size: CGSize
    @State private var userName: String = "User Full Name"
    
    var body: some View {
        ZStack(alignment: .topLeading) {
           
                VStack(alignment: .leading,spacing: 0) {
                    ScrollView {
                    TableCell(logo: {
                        LogoImage {
                            Image("VKlogo")
                        }
                    }, lable: {
                        Text(userName)
                    }, width: size.width)
                    
                    TableCell(logo: {
                        LogoImage {
                            Image(systemName: "hand.raised.square.on.square.fill")
                        }
                    }, lable: {
                        Text("1241212412414124124")
                    }, width: size.width)
                    TableCell(logo: {
                        LogoImage {
                            Image(systemName: "flag.2.crossed")
                        }
                    }, lable: {
                        Text("09jnf0iewnfj1")
                    }, width: size.width)
                    Spacer()
                }
                .frame(width: size.width,height: size.height)
                .background(Color.red)
            }
        }
        
        
    }
    
}


struct TableCell: View {
    var logo: LogoImage
    var lable: Text
    var width: CGFloat
    
    init(@ViewBuilder logo: () -> LogoImage, @ViewBuilder lable: () -> Text, width: CGFloat) {
        self.logo = logo()
        self.lable = lable()
        self.width = width
    }
    
    var body: some View {
            HStack(alignment: .center) {
                    logo
                    .padding(10)
                    lable
                    .padding(.leading, 15)
                Spacer()
                }
                .frame(minWidth: width)
                .background(Color.gray.opacity(0.3))
                .frame(height: 80)
    }
}


//MARK: logo View
struct LogoImage: View {
    var content: Image
    
    init(@ViewBuilder content: () -> Image) {
        self.content = content()
    }
    
    var body: some View {
        content
            .resizable()
            .frame(width: 50,height: 50)
            .modifier(CircleShadow(color: .red, circleRadius: 50, shadowRadius: 8))
    }
}


struct _FriendsCellView: View {
    var body: some View {
        ZStack {
            GeometryReader { geo in
                FriendsCellView(size: geo.size)
            }
        }
    }
}
// Для превью FriendsCell
struct FriendsCell_Previews: PreviewProvider {
    
    static var previews: some View {
        
        _FriendsCellView()
        
    }
}
