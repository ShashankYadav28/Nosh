//
//  OrderView.swift
//  Appetizers
//
//  Created by Sean Allen on 11/8/20.
//

import SwiftUI

struct OrderView: View {
    
    @EnvironmentObject var order: Order
 //   @State var orderAppetizer:OrderItem
    
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    List {
                        ForEach(order.items) { orderitem in
                            AppetizerListCell(appetizer: orderitem.appetizer)
                        }
                        .onDelete { IndexSet in
                            order.items.remove(atOffsets: IndexSet)
                        }
                    }
                    .listStyle(PlainListStyle())
                    
                    Button {
                        print("order placed")
                    } label: {
                        APButton(title: "$\(order.totalPrice, specifier: "%.2f") - Place Order")
                        //Text("$\(order.totalPrice, specifier: "%.2f") - Place Order")
                    }
                   // .modifier(StandardButtonStyle())
                    .padding(.bottom, 25)
                }
                
                if order.items.isEmpty {
                    EmptyState(imageName: "empty-order",
                               message: "You have no items in your order.\nPlease add an appetizer!")
                }
            }
            .navigationTitle("🧾 Orders")
        }
    }
}

struct OrderView_Previews: PreviewProvider {
    static var previews: some View {
        OrderView()
            .environmentObject(Order())
    }
}
