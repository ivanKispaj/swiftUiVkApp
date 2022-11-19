//
//  CodeAuthentificate.swift
//  swiftUiVkApp
//
//  Created by Ivan Konishchev on 19.11.2022.
//

import SwiftUI

struct CodeAuthentificate: View {
    
    @State private var code: String = ""
    @State var authModel: AuthorizationModel
    @State var isWrong: Bool = false
    @FocusState private var isFocused: Bool
    @State var biometric: Bool = false
    
    var body: some View {
      // BIOMETRIC AUTHORIZATION
        if biometric {
            ZStack {
                
            }
            .task {
                await  authModel.authenticate { result in
                    if !result {
                        self.biometric = result
                    }
                }
            }
        } else {
        // CODE AUTHORIZATION
            HStack {
                VStack {
                    Text("Введите пароль")
                        .padding(.bottom, 10)
                    HStack(alignment: .center) {
                        
                        
                        if code.count >= 1 {
                            Image(systemName: "circle.fill")
                                .frame(width: 20, height: 20)
                                .foregroundColor(.green)
                        } else {
                            Image(systemName: "circle.fill")
                                .frame(width: 20, height: 20)
                        }
                        
                        if code.count >= 2 {
                            Image(systemName: "circle.fill")
                                .frame(width: 20, height: 20)
                                .foregroundColor(.green)
                        } else {
                            Image(systemName: "circle.fill")
                                .frame(width: 20, height: 20)
                        }
                        
                        if code.count >= 3 {
                            Image(systemName: "circle.fill")
                                .frame(width: 20, height: 20)
                                .foregroundColor(.green)
                        } else {
                            Image(systemName: "circle.fill")
                                .frame(width: 20, height: 20)
                        }
                        
                        if code.count >= 4 {
                            Image(systemName: "circle.fill")
                                .frame(width: 20, height: 20)
                                .foregroundColor(.green)
                        } else {
                            Image(systemName: "circle.fill")
                                .frame(width: 20, height: 20)
                        }
                        
                    }
                    .padding()
                    .frame(height: 30)
                    
                    SecureField(text: $code, prompt: Text("")) {
                        Text("")
                    }
                    .frame(width: 0,height: 0)
                    .padding(0)
                    .focused($isFocused)
                    .onChange(of: code) { newValue in
                        if newValue.count >= 4 {
                            self.code = String(newValue.prefix(4))
                            self.verifyLogin()
                            
                        }
                    }
                }
                .scaleEffect(isWrong ? 0.6 : 1)
                
            }
            .onAppear {
                isFocused = true
                
            }
            .onTapGesture {
                isFocused = true
            }
            .frame(width: 150)
            .keyboardType(.decimalPad)
            .padding()
            .background(Color.blue.opacity(0.2))
            .cornerRadius(5.0)
            .shadow(color: Color.white, radius: 8, x: -8, y: -8)
            .shadow(color: Color.black, radius: 8, x: 8, y: 8)
 
//MARK: View для отображене кнопки вызова faceId or TouchId
            VStack {
                if authModel.isbiometricAuthorization  {
                    switch self.authModel.biometricType {
                   
                    case .faceID:
                        Image(systemName: "faceid")
                            .resizable()
                            .frame(width: 40,height: 40)
                            .onTapGesture {
                                if authModel.isbiometricAuthorization {
                                    self.biometric = true
                                }
                            }
                            .padding(.top, 20)
                    default:
                        Image(systemName: "touchid")
                            .resizable()
                            .frame(width: 40,height: 40)
                            .onTapGesture {
                                if authModel.isbiometricAuthorization {
                                    self.biometric = true
                                }
                            }
                            .padding(.top, 20)
                    }
                }
            }
        }
        
        
    }
    
//MARK: - VERIFY  ENTER CODE
    private func verifyLogin() {
        if authModel.code == self.code.toBase64() {
            self.authModel.isUnlocked = true
        } else {
            isWrong.toggle()
            DispatchQueue.main.async {
                withAnimation (.spring(response: 0.5,dampingFraction: 0.6)) {
                    isWrong.toggle()
                    self.code = ""
                }
            }
            
        }
    }
    
}


