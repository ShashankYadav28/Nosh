//
//  OrderView.swift
//  Appetizer app
//
//  Created by Shashank Yadav on 30/08/25.
//

import SwiftUI

struct OrderView: View {
    @State private var orderItem  = MockData.orderItem
    var body: some View {
        NavigationView{
            ZStack{
                VStack{
                    List{
                        ForEach(orderItem, id: \.id) { orderitem in
                            AppetizerListCell(appetizer: orderitem)
                        }
                        .onDelete(perform: deleteItem)
                    }
                    .listStyle(PlainListStyle())
                    
                    Button {
                        print("order placd ")
                    }label: {
                        APButton(title: "$12 - Place Order")
                    }
                    .padding(.bottom,25)
                }
                .navigationTitle("Orders")
                
                if orderItem.isEmpty {
                    OrderViewEmptyState(imageName: "empty-order", message: "You have no items in oyur orders.\n please add the appetizer")
                    
                }
            }
            
        }
       
    }
    func deleteItem(at Offsets: IndexSet){
        orderItem.remove(atOffsets: Offsets)
    }
}

#Preview {
    OrderView()
}
