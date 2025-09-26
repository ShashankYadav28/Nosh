//
//  Order.swift
//  Appetizer app
//
//  Created by Shashank Yadav on 19/09/25.
//

//.reduce(0) means start form the zero and $0+$1 means
// $0 means start from the zero and $1 current appetizer object

//reduce(0) → Starts at 0.
//$0 = running total, $1 = each OrderItem.
//$1.totalPrice → Each item’s cost (quantity × price).
//Returns the sum of all item prices → the cart total.

import SwiftUI

final class Order:ObservableObject {
    @Published var items:[OrderItem] = []
    
    var totalPrice: Double {
        items.reduce(0) {
            $0 + $1.totalPrice
        }
            
    }
    
    func add(_ appetizer:Appetizer ){
        if let index  = items.firstIndex(where: {$0.appetizer.id == appetizer.id}){
            items[index].quantity += 1
            
        }
        else {
            let newItem = OrderItem(appetizer: appetizer, quantity: 1)
            items.append(newItem)
        }
            
    }
    
    func remove(at offsets: IndexSet){
        items.remove(atOffsets: offsets)
    }
    
    func clear() {
        items.removeAll()
    }
}






