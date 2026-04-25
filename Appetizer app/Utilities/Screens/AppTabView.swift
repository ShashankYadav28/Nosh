//
//  ContentView.swift
//  Appetizers
//
//  Created by Sean Allen on 11/8/20.
//

import SwiftUI

struct AppTabView: View {

    @EnvironmentObject var order: Order
    @State private var selectedTab = 0

    var body: some View {

        TabView(selection: $selectedTab) {

            AppetizerListView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                .tag(0)

            AccountView()
                .tabItem {
                    Label("Account", systemImage: "person")
                }
                .tag(1)

            OrderView(selectedTab: $selectedTab)
                .tabItem {
                    Label("Order", systemImage: "bag")
                }
                .badge(order.items.count)
                .tag(2)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AppTabView()
            .environmentObject(Order())
    }
}
