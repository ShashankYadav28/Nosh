//
//  OrderItem.swift
//  Appetizer app
//
//  Created by Shashank Yadav on 24/09/25.
//

import SwiftUI
struct OrderItem:Identifiable {
    let id = UUID()
    let appetizer:Appetizer
    var quantity:Int
    
    var totalPrice:Double {
        Double(quantity) * appetizer.price
    }
    
    
}


