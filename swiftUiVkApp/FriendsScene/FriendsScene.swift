//
//  FriendsScene.swift
//  swiftUiVkApp
//
//  Created by Ivan Konishchev on 30.10.2022.
//

import SwiftUI
import UIKit


struct FriendsScene: View {
    
    @State var isOnScreen: Int = 0
    @EnvironmentObject var userData: UserRegistrationData
    var transition: Int {
        if isOnScreen == 0 {
            return withAnimation(.spring(response: 1, dampingFraction: 0.5, blendDuration: 100.0)) {
                0
            }
        }
        return withAnimation (.spring(response: 0.1, dampingFraction: 0.1, blendDuration: 100.0)) {
            10
        }
    }
    
    @ObservedObject var viewModel: FriendsViewModel
    @State var nextDestination: String = ""
    @State var selection = false
    @State private var isloadedFriend = false
  //  private var userId = UserDefaults.standard.string(forKey: self.userData.userId)
    
    init(viewModel: FriendsViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        
        NavigationStack(root: {
            ZStack {
                List {
                    ForEach(self.viewModel.groupedFiends, id: \.self) { item in
                        Section(header:
                                    Text(item.header)
                        ){
                            ForEach(item.rows, id: \.self) { friend in
                                FriendsCellView(friend: friend)
                                    .swipeActions(content: {
                                        VStack {
                                            Text("delite")
                                            Button(role: .destructive) {
                                                print("delite")
                                            } label: {
                                                Image(systemName: "trash")
                                            }
                                            .opacity(0.2)
                                            
                                        }
                                    })

                                
                            }
                            .listRowBackground(Color.gray.opacity(0.2))
                        }
                    }
                    
                }
                
                .frame( maxWidth: .infinity)
                .listStyle(GroupedListStyle())
                
            }
            
            .navigationTitle("Друзья")
            .navigationBarTitleDisplayMode(.inline)
            
        })
        
        .onAppear {
            if isloadedFriend {
                
            } else {
                viewModel.internetConnection.loadFriends(for: userData.userId,token: userData.token) { response in
                    self.isloadedFriend.toggle()
                    DispatchQueue.main.async {
                        self.viewModel.setGroupedFriends(from: response)
                    }
                }
            }
        }
    }
    private func textToImage(drawText text: String, inImage image: UIImage, atPoint point: CGPoint) -> UIImage {
        let textColor = UIColor.blue
        let textFont = UIFont(name: "Helvetica Bold", size: 10)!
        
        let scale = UIScreen.main.scale
        var size = image.size
        size.height = 60
        size.width = 60
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        
        let textFontAttributes = [
            NSAttributedString.Key.font: textFont,
            NSAttributedString.Key.foregroundColor: textColor,
        ] as [NSAttributedString.Key : Any]
        image.draw(in: CGRect(origin: CGPoint(x: 20, y: 15), size: image.size))
        
        
        let rect = CGRect(origin: point, size: size)
        
        text.draw(in: rect, withAttributes: textFontAttributes)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
}


struct LabelStyleCustom: View {
    
    var body: some View {
        VStack {
            Image(systemName: "pencil")
                .resizable()
                .frame(width: 10,height: 10)
            Text("pencile")
                .fontWeight(.ultraLight)
        }
        .frame(width: 50,height: 50)
    }
}



extension View {
    @ViewBuilder
    func swipeAction(@ViewBuilder _ content: @escaping () -> some View) -> some View {
        VStack(spacing: 0) {
            Image(systemName: "trash")
                .font(.system(size: 18.0))
                .foregroundColor(.white)
                .frame(width: 60, alignment: .center)
                .frame(maxHeight: .infinity) // <====== HERE
            
            
            Text("Delite")
                .foregroundColor(.black)
                .font(.system(size: 12))
                .padding(.bottom, 10)
            
            //  .animation(.spring(), value: isOnScreen )
            
        }
        .background(.red)
    }
}

