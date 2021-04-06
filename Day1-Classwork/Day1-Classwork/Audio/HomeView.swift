//
//  HomeView.swift
//  Day1-Classwork
//
//  Created by Samuel Folledo on 4/1/21.
//

import SwiftUI

struct HomeView: View {
    
    @State var isLoggedIn = false
    @State var showPlayer = false
    
    var body: some View {
        NavigationView {
            VStack{
                Button {
                    showPlayer.toggle()
                } label: {
                    NavigationLink(
                        destination: AudioView(), isActive: $showPlayer,
                        label: {
                            EmptyView()
                        })
                    Text(showPlayer ? "Showing": "Wait")
                }
            }
            .padding()
        }
    }
}
