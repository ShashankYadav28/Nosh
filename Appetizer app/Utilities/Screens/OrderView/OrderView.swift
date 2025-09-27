//
//  OrderView.swift
//  Appetizers
//
//  Created by Sean Allen on 11/8/20.
//

import SwiftUI
struct OrderView: View {
    
    @State private var showConformationScreen = false
    @EnvironmentObject var order: Order
    
    
 //   @State var orderAppetizer:OrderItem
    
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    List {
                        ForEach(order.items,id: \.id) { item in
                            orderLIstCell(orderItem: item)

                        }
                        .onDelete { IndexSet in
                            order.items.remove(atOffsets: IndexSet)
                        }
                    }
                    .listStyle(PlainListStyle())
                    
                    Button {
                        showConformationScreen = true
                        
                    } label: {
                        APButton(title: "$\(order.totalPrice, specifier: "%.2f") - Place Order")
                        //Text("$\(order.totalPrice, specifier: "%.2f") - Place Order")
                    }
                   // .modifier(StandardButtonStyle())
                    .padding(.bottom, 25)
                    .sheet(isPresented: $showConformationScreen) {
                        OrderConformationScreen( showConformationScreen: $showConformationScreen)
                    }
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
