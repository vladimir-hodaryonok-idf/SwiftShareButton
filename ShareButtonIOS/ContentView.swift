//
//  ContentView.swift
//  ShareButtonIOS
//
//  Created by Vladimir on 21.09.22.
//

import SwiftUI


struct ContentView: View {
    @State private var message : String = ""
    func share(){
        let controller = UIActivityViewController(activityItems:[message], applicationActivities: nil)
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let window = windowScene?.windows.first
        window?.rootViewController?.present(controller, animated: true)
    }

    var body: some View {
        VStack {
            TextField(text: $message){
            }.border(.secondary)
            Button("Share",action: share)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
