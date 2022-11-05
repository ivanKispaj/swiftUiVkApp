//
//  NewsSceneView.swift
//  swiftUiVkApp
//
//  Created by Ivan Konishchev on 30.10.2022.
//

import SwiftUI



struct NewsSceneView: View {
    
    @State var path = NavigationPath()
    @State private var selection: String = ""
    @State private var ispresent = false
    var body: some View {
        NavigationStack {
     
            NavigationLink("") {
                NewsSceneView2()
            }
            .navigationDestination(isPresented: $ispresent) {
                NewsSceneView2()
            }
            
            VStack {
                Text(selection)
                Spacer()
                Button("Tap to show second") {
                    self.selection = "Second"
                }
                Text("")
                Button("Tap to show third") {
                    self.ispresent = true
                    self.selection = "Third"
                    
                }
                Spacer()
            }
            .navigationTitle("News")
            .navigationBarTitleDisplayMode(.inline)
        }
  
        
       
   
     


        

        
        
        
        
        
    }
    
    //   }
    //          //  NavigationLink(destination: NewsSceneView2(), tag: "Second", selection: $selection) {
    //
    //
    //            }
    //            .navigationBarTitleDisplayMode(.inline)
    //            .navigationTitle(selection ?? "NIl")
    //
    //
    
    
    //   }
}

//
//struct NewsSceneView: View {
//
//    @State var isActive = true
//
//    var body: some View {
//        ZStack {
//
//            NavigationLink(destination: NewsSceneView2(), isActive: $isActive) {
//
//            }
//        }
//        .background(Image(systemName: "homekit"))
//        }
//
//
//    }


struct NewsSceneView2: View {
    
    var body: some View {
        ZStack {
            
        }
        .background(Image(systemName: "music.note.house.fill"))
        
        .navigationTitle("News2")
    }
}



