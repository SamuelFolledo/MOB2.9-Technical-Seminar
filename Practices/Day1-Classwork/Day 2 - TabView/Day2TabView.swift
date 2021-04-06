//
//  Day2TabView.swift
//  Day1-Classwork
//
//  Created by Samuel Folledo on 4/6/21.
//

import SwiftUI

struct Day2TabView: View {
    
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab,
                content: {
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
                .onAppear(perform: {
                    selectedTab = 0
                })
                .tag(0)
            ProfileView()
                .tabItem {
                    Image(systemName: "person.crop.circle")
                    Text("Profile")
                }
                .onAppear(perform: {
                    selectedTab = 1
                })
                .tag(1)
            SettingsView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
                }
                .onAppear(perform: {
                    selectedTab = 2
                })
                .tag(2)
        })
    }
}

struct Day2TabView_Previews: PreviewProvider {
    static var previews: some View {
        Day2TabView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
            .previewDisplayName("User Preview iPhone 8")
    }
}

//MARK: - Views
struct HomeView: View {
    @State var goToDetail = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.blue.opacity(0.2)
                Button(action: {
                    goToDetail.toggle()
                }, label: {
                    Text("Go To Details")
                })
                NavigationLink(
                    destination: TabDetailView(text: "Home"),
                    isActive: $goToDetail,
                    label: {
                        EmptyView()
                    })
            }
            .navigationTitle("Home")
        }
    }
}

struct SettingsView: View {
    @State var goToDetail = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black
                Button(action: {
                    goToDetail.toggle()
                }, label: {
                    Text("Go To Details")
                })
                NavigationLink(
                    destination: TabDetailView(text: "Settings"),
                    isActive: $goToDetail,
                    label: {
                        EmptyView()
                    })
            }
            .navigationTitle("Settings")
        }
    }
}

struct ProfileView: View {
    @State var goToDetail = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.gray
                Button(action: {
                    goToDetail.toggle()
                }, label: {
                    Text("Go To Details")
                })
                NavigationLink(
                    destination: TabDetailView(text: "Profile"),
                    isActive: $goToDetail,
                    label: {
                        EmptyView()
                    })
            }
            .navigationTitle("Profile")
        }
    }
}

struct TabDetailView: View {
    let text: String
    var body: some View {
        Text(text)
    }
}
