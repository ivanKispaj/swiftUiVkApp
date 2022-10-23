//
//  ContentView.swift
//  swiftUiVkApp
//
//  Created by Ivan Konishchev on 18.10.2022.
//

import SwiftUI
import Combine

struct LoginScreen: View {
    @State private var center: CGFloat = UIScreen.main.bounds.height / 2
    @State private var email: String = ""
    @State private var password = ""
    @State private var isTrue = true
    @State private var should: CGFloat = 130
    var size: CGSize
    private let keyboardIsOnPublisher = Publishers.Merge( NotificationCenter.default.publisher(for: UIResponder.keyboardWillChangeFrameNotification)
        .map { _ in true }, NotificationCenter.default.publisher(for:
                                                                    UIResponder.keyboardWillHideNotification) .map { _ in false }
    )
        .removeDuplicates()
    
    var body: some View {
        
        ZStack {
            
            // backgroundImage
            GeometryReader { geometry in
                Image("VKlogo")
                    .frame(width: geometry.size.width,height: geometry.size.height)
                    .opacity(0.6)
                
            }
            
            // ScrollView
            
            ScrollView(showsIndicators: false) {
                
                VStack {
                    
                    VStack {
                        
                        if isTrue {
                            Text("Войти") .font(.largeTitle)
                                .padding(.top, 15)
                        } else {
                            Text("Вошли") .font(.largeTitle)
                                .padding(.top, 15)
                        }
                        
                        VStack {
                            HStack {
                                Text("Email: ")
                                    .font(Font.system(size: 20,design: .monospaced))
                                    .frame(width: 150)
                                TextField("Enter Your Email", text: $email)
                                    .background(Color(UIColor.lightGray))
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .frame(width: 200)
                                
                            }
                            
                            Spacer()
                            
                            HStack {
                                Text("Password: ")
                                    .font(Font.system(size: 20,design: .monospaced))
                                    .frame(width: 150)
                                
                                SecureField("Enter Your password", text: $password)
                                    .background(Color(UIColor.lightGray))
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .frame(width: 200)
                                    .accessibilityRespondsToUserInteraction()
                                
                            }
                        }
                        .frame(minWidth: size.width)
                        
                        Spacer(minLength: 20)
                        
                        Button(action: {
                            self.isTrue.toggle()
                            
                        }) {
                            Text("Войти")
                        }
                        .padding(.bottom, 20)
                        .disabled(email.isEmpty || password.isEmpty)
                        .tint(  .primary)
                        
                        .buttonStyle(.bordered)
                       .buttonBorderShape(.roundedRectangle(radius: 10))
                    }
                    .background(Color.gray.opacity(0.3))
                    .onReceive(keyboardIsOnPublisher) { isKeyboardOn in
                        withAnimation(Animation.easeInOut(duration: 0.5)) {
                            if isKeyboardOn {
                                self.should = 180
                            } else {
                                self.should = 130
                            }
                        }
                    }
                }
                
                .padding(.top, size.height / 2 - self.should)
            }
            .onTapGesture {
                 UIApplication.shared.endEditing()
            
             }
            
        }
        
    }
    
}


// чтобы передать размер екрана
struct _ContentView: View {
    var body: some View {
        GeometryReader { proxy in
            LoginScreen(size: proxy.size)
        }
        .edgesIgnoringSafeArea(.all)
    }
    
    
}

// для удаления клавиатуры по тапу в свободном месте
extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
}

// Для превью
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        _ContentView()
        
    }
}

