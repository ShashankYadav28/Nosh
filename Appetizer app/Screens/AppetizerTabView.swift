//
//  ContentView.swift
//  Appetizer app
//
//  Created by Shashank Yadav on 30/08/25.
//

import SwiftUI

struct AppetizerTabView: View {
    var body: some View {
        TabView {
            AppetizerListView()
                .tabItem {
                    Label("Home",systemImage: "house")
                   // ForEach()
                }
            AccountView()
                .tabItem {
                    Label("Account",systemImage:"person.fill")
                    
                }   
            OrderView()
                .tabItem {
                    Label("Order",systemImage:"bag.fill")
                    
                }
        }
        .accentColor(Color(.brandPrimary))
    }
}

#Preview {
    AppetizerTabView()
}
