//
//  OrderHistoryModel.swift
//  Appetizer app
//
//  Created by Shashank Yadav on 27/09/25.
//

import Foundation

final class OrderHistoryModel: ObservableObject{
   // @Published var pastOrders:[[OrderItem]] = []
    @Published var pastOrders:[Order] = []
}
