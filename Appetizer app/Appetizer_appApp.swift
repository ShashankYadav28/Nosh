//
//  Appetizer_appApp.swift
//  Appetizer app
//
//  Created by Shashank Yadav on 30/08/25.
//

import SwiftUI

@main
struct Appetizer_appApp: App {
    var order = Order()
    var body: some Scene {
        WindowGroup {
            AppetizerTabView()
                .environmentObject(order)  // injecting the object so that we can use it anywhere
                                            // now it has become the environmrnt object
        }                                    // to access the object  need to use @Environment
    }
}
