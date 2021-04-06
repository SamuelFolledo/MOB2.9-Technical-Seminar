//
//  Day2TabView.swift
//  Day1-Classwork
//
//  Created by Samuel Folledo on 4/6/21.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color.blue
            }
            .navigationTitle("Home")
        }
    }
}

struct SettingsView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color.black
            }
            .navigationTitle("Settings")
        }
    }
}

struct Day2TabView: View {
    
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            SettingsView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
                }
        }
    }
}

struct Day2TabView_Previews: PreviewProvider {
    static var previews: some View {
        Day2TabView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
            .previewDisplayName("User Preview iPhone 8")
    }
}
