//
//  Appetizer_appApp.swift
//  Appetizer app
//
//  Created by Shashank Yadav on 30/08/25.
//

import SwiftUI

@main
struct Appetizer_appApp: App {
    @StateObject var order = Order()
    @State private var showSplash = true
    @StateObject private var OrderHistory = OrderHistoryModel()
    var body: some Scene {
        WindowGroup {
            
            if showSplash {
               SplashScreen(showSplash: $showSplash)
                    
            }
            else {
                AppetizerTabView()
                    .environmentObject(order)               // injecting the object so that we can use it anywhere in the view in the childview etc
                    .environmentObject(OrderHistory)
                // now it has become the environmrnt object
                // to access the object  need to use @Environment
            }
        }
    }
}

