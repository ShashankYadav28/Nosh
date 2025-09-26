//
//  OrderItem.swift
//  Appetizer app
//
//  Created by Shashank Yadav on 24/09/25.
//

import SwiftUI
final class OrderItem:Identifiable,ObservableObject {
    let id = UUID()
    let appetizer:Appetizer
   @Published var quantity:Int
    
    var totalPrice:Double {
        Double(quantity) * appetizer.price
    }
    
   init(appetizer: Appetizer, quantity: Int) {
        self.appetizer = appetizer
        self.quantity = quantity
    }
}


