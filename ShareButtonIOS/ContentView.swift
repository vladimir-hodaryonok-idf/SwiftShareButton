//
//  ContentView.swift
//  ShareButtonIOS
//
//  Created by Vladimir on 21.09.22.
//

import SwiftUI
import PhotosUI

struct ContentView: View {
      @State private var message : String = ""
      @State private var selectedImage : PhotosPickerItem? = nil
      @State private var selectedImageData: Data? = nil
      
      private func shareContent(content : Any){
            let controller = UIActivityViewController(activityItems:[content], applicationActivities: nil)
            let scenes = UIApplication.shared.connectedScenes
            let windowScene = scenes.first as? UIWindowScene
            let window = windowScene?.windows.first
            window?.rootViewController?.present(controller, animated: true)
      }
      
      var body: some View {
            VStack {
                  TextField(text: $message){
                  }.border(.secondary)
                  Button("Share Text",action: {shareContent(content: message)})
                  PhotosPicker(
                        selection: $selectedImage,
                        matching: .images,
                        photoLibrary: .shared()) {
                              Text("Select a photo")
                        }.onChange(of: selectedImage) { newItem in
                              Task {
                                    if let data = try? await newItem?.loadTransferable(type: Data.self) {
                                          selectedImageData = data
                                    }
                              }
                        }
                  if (selectedImageData.self != nil){
                        Button(
                              "Share Image",
                              action: {shareContent(content: selectedImageData as Any)
                                    
                              }
                        )
                  }
                  
            }
            .padding()
      }
}

struct ContentView_Previews: PreviewProvider {
      static var previews: some View {
            ContentView()
      }
}
