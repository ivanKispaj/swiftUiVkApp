//
//  ContentView.swift
//  swiftUiVkApp
//
//  Created by Ivan Konishchev on 18.10.2022.
//

import SwiftUI
import Combine

struct ContentView: View {
    @State private var center: CGFloat = UIScreen.main.bounds.height / 2
    @State private var email: String = ""
    @State private var login = ""
    @State private var password = ""
    @State private var isTrue = true
    
    private let keyboardIsOnPublisher = Publishers.Merge( NotificationCenter.default.publisher(for: UIResponder.keyboardWillChangeFrameNotification)
        .map { _ in true }, NotificationCenter.default.publisher(for:
                                                                    UIResponder.keyboardWillHideNotification) .map { _ in false }
    )
        .removeDuplicates()
    
    var body: some View {
        let _ = print("Update ContentView")
        ZStack {
            // backgroundImage
            Image("VKlogo")
                .resizable()
                .scaledToFit()
                .edgesIgnoringSafeArea(.all)
                .opacity(0.5)
            // ScrollView
            ScrollView(.vertical) {
                
                Spacer(minLength: self.center
                       - 200)
                VStack {
                    if isTrue {
                    Text("Войти") .font(.largeTitle) .padding(.top, 32)
                    } else {
                        Text("Вошли") .font(.largeTitle) .padding(.top, 32)
                    }
                    HStack {
                        Text("Email: ")
                            .font(Font.system(size: 20,design: .monospaced))
                            .frame(width: 150)
                        TextField("Enter Your Email", text: $email)
                            .background(Color(UIColor.lightGray))
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: 200)
                    }
                    .padding(.top, 40)
                    
                    Spacer()
                    
                    HStack {
                        Text("Password: ")
                            .font(Font.system(size: 20,design: .monospaced))
                            .frame(width: 150)
                        
                        SecureField("Enter Your password", text: $password)
                            .background(Color(UIColor.lightGray))
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: 200)
                    }
                    .padding(25)
                    
                    HStack{
                        Button(action: {
                            isTrue.toggle()
                        })
                        {
                            Text("Войти")
                        }
                       
                        .padding(.top, 8)
                        .padding(.trailing, 40)
                        .padding(.leading, 40)
                        .padding(.bottom, 8)
                        .disabled(email.isEmpty || password.isEmpty)
                        .background(Color(UIColor.white))
                        .onReceive(keyboardIsOnPublisher) { isKeyboardOn in withAnimation(Animation.easeInOut(duration: 0.5)) {
                            
                        }
                            
                        }
                    }
                    .padding(.bottom, 20)
                }
                .frame(width: UIScreen.main.bounds.width)
                .background(Color(UIColor.systemGray).opacity(0.4))
                
                
            }
           
        }
    
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}




