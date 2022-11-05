//
//  LoginScene.swift
//  swiftUiVkApp
//
//  Created by Ivan Konishchev on 27.10.2022.
//

import SwiftUI
import Combine


//MARK: - Код для первого ДЗ !!!!!!!

//struct LoginScene: View {
//
//    @State private var login: String = ""
//    @State private var password: String = ""
//    @State private var alertMessage: String = ""
//    @State private var showIncorrectFillTextfield = false
//    @State private var isLogged = false
//    var body: some View {
//
//        ZStack {
//            GeometryReader { geometry in
//                Image("VKlogo")
//                    .frame(width: geometry.size.width, height: geometry.size.height)
//
//                VStack(alignment: .center) {
//
//                    ScrollView {
//                        /*
//                         Стек блока с полями входа
//                         Задана высота 300
//                         и спозиционирован по центру эерана
//                         */
//                        VStack {
//
//                            VStack {
//                                Text("Вход")
//                                    .font(Font.largeTitle)
//                            }
//                            // поле логина
//                            HStack {
//                                Spacer()
//                                Text("Login: ")
//                                    .frame(minWidth: 100)
//                                    .lineLimit(1)
//                                TextField("Email", text: $login)
//                                    .textFieldStyle(.roundedBorder)
//                                Spacer()
//
//                            }
//                            // поле пароля
//                            HStack {
//                                Spacer()
//                                Text("Password: ")
//                                    .frame(minWidth: 100)
//                                    .lineLimit(1)
//                                SecureField("password", text: $password)
//                                    .textFieldStyle(.roundedBorder)
//                                Spacer()
//                            }
//
//                            // Кнопка регистрации
//                            VStack(alignment: .center) {
//                                Button(action: {
//                                    verifyInputData()
//                                }, label: {
//
//                                    Text("Войти")
//                                })
//                                .fullScreenCover(isPresented: $isLogged, content: {
//
//                                    TabBarView()
//
//                                })
//
//                                .padding(.top, 30)
//                                .buttonStyle(.bordered)
//                                .tint(Color("BlackWhite"))
//                                .disabled(login.isEmpty || password.isEmpty)
//
//                            }
//                        }
//                        .frame(width: geometry.size.width, height: 300)
//                        .background(Color.gray.opacity(0.4))
//                        .padding(.top, (geometry.size.height / 2) - 150)
//                    }
//
//
//                }
//                .frame(width: geometry.size.width,height: geometry.size.height)
//                .alert(isPresented: $showIncorrectFillTextfield) {
//                    Alert(title: Text("Error"), message: Text(alertMessage))
//                }
//
//            }
//
//        }
//
//
//    }
//
//
//    private func verifyInputData() {
//        if login != "A@a.ru" {
//            self.alertMessage = "Email incorrect! Please try again"
//            self.showIncorrectFillTextfield = true
//        } else if password != "aaa" {
//                self.alertMessage = "Password incorrect! Please try again"
//            self.showIncorrectFillTextfield = true
//
//
//        } else {
//            isLogged = true
//            print("login: " + login + "and" + "password: " + password)
//        }
//
//    }
//
//}

//
//struct Preview_LoginScene: PreviewProvider {
//    static var previews: some View {
//        LoginScene(isUserLoggedIn: false)
//    }
//}
