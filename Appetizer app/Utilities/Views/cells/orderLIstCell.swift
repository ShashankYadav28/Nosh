//
//  orderLIstCell.swift
//  Appetizer app
//
//  Created by Shashank Yadav on 25/09/25.
//

import SwiftUI

struct orderLIstCell: View {
    @EnvironmentObject var order:Order
    let orderItem:OrderItem
    var body: some View {
        HStack{
            AppetizerRemoteImage(imageURL: orderItem.appetizer.imageURL)
                .aspectRatio(contentMode: .fill)
                .frame(width:120,height:120)
                .clipped()
                .cornerRadius(8)
            
            VStack{
                Text(orderItem.appetizer.name)
                    .font(.title2)
                    .fontWeight(.medium)
                    
                Text("$\(orderItem.appetizer.price,specifier: "%.2f")")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            HStack(spacing:10){
                Button{
                    if let index = order.items.firstIndex(where: {$0.id == orderItem.id}){
                        order.items[index].quantity+=1
                        
                        
                    }
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .foregroundColor(.green)
                        .font(.title3)
                    
                    
                }
                
                Text("\(orderItem.quantity)")
                    .font(.headline)
                
                Button {
                    if let index = order.items.firstIndex(where: {$0.id == orderItem.id}){
                        order.items[index].quantity -= 1
                        
                    }
                }label: {
                    Image(systemName: "minus.circle.fill")
                        .foregroundColor(.red)
                        .font(.title3)
                    
                }
                

                
                
            }
            
        }
        
    }
}

#Preview {
    orderLIstCell(orderItem: OrderItem(appetizer: MockData.sampleAppetizer, quantity: 2))
        .environmentObject(Order())
}
