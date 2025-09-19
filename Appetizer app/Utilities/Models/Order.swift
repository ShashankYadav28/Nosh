//
//  Order.swift
//  Appetizer app
//
//  Created by Shashank Yadav on 19/09/25.
//

import SwiftUI

final class Order:ObservableObject {
    @Published var items:[Appetizer] = []
    
    var totalPrice: Double {
        items.reduce(0) {   // .reduce(0) means start form the zero and $0+$1 means
                            // $0 means start from the zero and $1 current appetizer object 
            
            $0+$1.price
        }
            
    }
}
