//
//  OrderConformationScreen.swift
//  Appetizer app
//
//  Created by Shashank Yadav on 27/09/25.
//

import SwiftUI

struct OrderConformationScreen: View {
    @EnvironmentObject var order:Order
    @Binding var showConformationScreen:Bool
    @State private var isProcessing  = true
    @State private var showSuccess = false
    //@StateObject private var Orderhistory = OrderHistoryModel()
    @EnvironmentObject var orderHistory:OrderHistoryModel
    var body: some View {
        ZStack {
            if isProcessing {
                ProgressView("Processing your order for the item ")
                    .progressViewStyle(CircularProgressViewStyle(tint: .brandPrimary))
                
            }
            
            if showSuccess {
                VStack(spacing:20) {
                    Image(systemName: "checkmark.circle.fill")
                        .resizable()
                        .frame(width:100,height:100)
                        .scaleEffect(showSuccess ? 1.2 : 1.0)
                        .animation(.easeInOut(duration: 0.3), value: showSuccess)
                    
                    Text("Order Confirmed")
                        .font(.title)
                        .font(.system(size: 32))
                        .fontWeight(.semibold)
                    
                    Text("Your order is on the way ")
                        .foregroundColor(.secondary)
                    
                    Button("back to Home"){
                        showConformationScreen = false
                        //orderHistory.pastOrders.append(order.items.map { OrderItem(appetizer: $0.appetizer, quantity: $0.quantity) })
                        
                        // i will not use the above case because i have to pass the many orders and if i pass the order items than i wiill not able to use quantity and the total price of the object 
                        order.clear()
                    }
                    .buttonStyle(.borderedProminent)
                    
                    
                    
                }
            }
            
        }
        .onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now()+2){   // means this may take time current threqad doesnot stops working
                                                                // means it will display the screen after the 2 seconds of the current instance of the time
                
                withAnimation(.easeIn(duration: 0.5)){

                    isProcessing = false
                    showSuccess = true
                    
                }
                
            }
        }
    }
    
}

#Preview {
    OrderConformationScreen( showConformationScreen: .constant(true))
     .environmentObject(Order())
}
