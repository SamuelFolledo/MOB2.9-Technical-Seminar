//
//  Day1SimpleView.swift
//  Day1-Classwork
//
//  Created by Samuel Folledo on 3/30/21.
//

import SwiftUI

struct Day1SimpleView: View {
    
    @State var isLoggedIn = false
    
    var body: some View {
        VStack{
            Text("Stay Safe")
                .font(.title)
            HStack {
                ImageWithLabelView(imageName: "01", text: "Wash hands frequently")
                Spacer()
                ImageWithLabelView(imageName: "02", text: "Wear a facemask")
            }
            HStack {
                ImageWithLabelView(imageName: "03", text: "Use hand sanitizer")
                Spacer()
                ImageWithLabelView(imageName: "04", text: "Self isolate if needed")
            }
            ImageWithLabelView(imageName: "05", text: "Minimal contact")
            Spacer()
            Text("Your COVID advice goes here")
            Spacer()
            Button {
                isLoggedIn.toggle()
            } label: {
                Text(isLoggedIn ? "Login": "Logout")
            }
        }
        .padding()
    }
}

struct Day1SimpleView_Previews: PreviewProvider {
    static var previews: some View {
        Day1SimpleView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
            .previewDisplayName("User Preview iPhone 8")
        
//        ContentView()
//                    .previewDevice(PreviewDevice(rawValue: "iPhone 12 Pro Max"))
//                    .previewDisplayName("Client Preview on iPhone 12 Pro Max")
    }
}

struct ImageWithLabelView: View {

    let imageName: String
    let text: String

    var body: some View {
        VStack {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
//                .frame(width: 100, height: 100)
            Text(text)
                .multilineTextAlignment(.center)
        }
    }
}



