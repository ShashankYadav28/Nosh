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
            VStack{
                List{
                    ForEach(MockData.orderItem, id: \.id) { orderitem in
                        AppetizerListCell(appetizer: orderitem)
                    }
                    .onDelete { IndexSet in
                        orderItem.remove(atOffsets: IndexSet)
                    }
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
        }
    }
}

#Preview {
    OrderView()
}
