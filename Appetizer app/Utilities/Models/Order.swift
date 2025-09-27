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
import Combine

final class Order:ObservableObject {
    @Published var items:[OrderItem] = []
    
    private var cancellables: Set<AnyCancellable> = []
    
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
            observe(item: newItem)
        }
            
    }
    
    func remove(at offsets: IndexSet){
        items.remove(atOffsets: offsets)
    }
    
    func clear() {
        items.removeAll()
    }
    
    private func observe(item:OrderItem) {   // here observe we are observing the item change
        item.objectWillChange                 // here it will emit the signal if the order item is changed
            .sink { [weak self] _ in          // .sink is used to listen to changes  and here waek self i have created for listening to the changes
                self?.objectWillChange.send()   // self? checks if the object still exists, then notifies SwiftUI of changes
            }
            .store(in: &cancellables)
    }
}






