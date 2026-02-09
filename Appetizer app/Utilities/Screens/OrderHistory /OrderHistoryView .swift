//
//  OrderHistoryView .swift
//  Appetizer app
//
//  Created by Shashank Yadav on 28/09/25.
//

import SwiftUI

struct OrderHistoryView : View {
    
    @EnvironmentObject var orderHistory:OrderHistoryModel
    
    var body: some View {
        Group {
            if orderHistory.pastOrders.isEmpty {
                Text("No past orders")
                    .foregroundColor(.gray)
                    .italic()
                    .navigationTitle("Order History")
                
            }
            else {
                
                List {
                    ForEach(orderHistory.pastOrders) { order in
                        
                        Section{
                            Text("Order Total:$\(order.totalPrice,specifier: "%.2f")")
                                .font(.title3)
                                .fontWeight(.semibold)
                                .foregroundColor(.primary)
                            ForEach(order.items){ item in
                                OrderRowView(item: item)
                                
                            }
                        }
                        
                    }
                }
            }
        }
        .navigationTitle("order History")
        .navigationBarTitleDisplayMode(.inline)
    }
}
#Preview {
    OrderHistoryView()
        .environmentObject(OrderHistoryModel())
}


struct OrderRowView: View {
    var item:OrderItem
    var body: some View{
        
            HStack {
                AppetizerRemoteImage(imageURL: item.appetizer.imageURL)
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 120, height: 120)
                    .clipped()
                    .cornerRadius(8)
                
                VStack(alignment: .leading){
                    
                    Text("\(item.appetizer.name)")
                        .font(.headline)
                    
                    Text("x\(item.quantity)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                }
                
                Spacer()
                
                Text("Order total Price : \(item.totalPrice)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                
            }
            .padding(.vertical,1)
          //  .navigationDestination(isPresented: <#T##Binding<Bool>#>, destination: <#T##() -> View#>)
        }
    }
