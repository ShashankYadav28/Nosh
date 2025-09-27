//
//  orderLIstCell.swift
//  Appetizer app
//
//  Created by Shashank Yadav on 25/09/25.
//

import SwiftUI

struct orderLIstCell: View {
   // @EnvironmentObject var order:Order
    @ObservedObject var orderItem:OrderItem
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
                
                Text("$\(orderItem.totalPrice,specifier: "%.2f")")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            HStack(spacing:10){
                Button{
                    print("Before: \(orderItem.quantity)")
                    orderItem.quantity+=1
                    print("After: \(orderItem.quantity)")
            
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .foregroundColor(.green)
                        .font(.title3)
                    
                    
                }
                .buttonStyle(PlainButtonStyle())
                
                Text("\(orderItem.quantity)")
                    .font(.headline)
                
                Button {
                    
                        if orderItem.quantity > 1 {
                            orderItem.quantity -= 1
                            
                    }
                }label: {
                    Image(systemName: "minus.circle.fill")
                        .foregroundColor(.red)
                        .font(.title3)
                    
                }
                .buttonStyle(PlainButtonStyle())
                
                
                
            }
            
        }
        
    }
}

#Preview {
    orderLIstCell(orderItem: OrderItem(appetizer: MockData.sampleAppetizer, quantity: 2))
      //  .environmentObject(Order())
}
