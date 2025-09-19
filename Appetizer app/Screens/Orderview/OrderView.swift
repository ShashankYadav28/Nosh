//
//  OrderView.swift
//  Appetizer app
//
//  Created by Shashank Yadav on 30/08/25.
//

import SwiftUI

struct OrderView: View {
   // @State private var orderItem  = MockData.orderItem we dont need the mock data
    @EnvironmentObject var orderItem:Order
    
    var body: some View {
        NavigationView{
            ZStack{
                VStack{
                    List{
                        ForEach(orderItem.items) { orderitem in
                            AppetizerListCell(appetizer: orderitem)
                        }
                        .onDelete(perform: deleteItem)
                    }
                    .listStyle(PlainListStyle())
                    
                    Button {
                        print("order placd ")
                    }label: {
                        APButton(title: "\(orderItem.totalPrice,specifier: "%.2f") - Place Order")
                    }
                    .padding(.bottom,25)
                }
                .navigationTitle("Orders")
                
                if orderItem.items.isEmpty {
                    OrderViewEmptyState(imageName: "empty-order", message: "You have no items in oyur orders.\n please add the appetizer")
                    
                }
            }
            
        }
       
    }
    func deleteItem(at Offsets: IndexSet){
        orderItem.items.remove(atOffsets: Offsets)
    }
}

#Preview {
    OrderView()
}
