//
//  OrderConformationScreen.swift
//  Appetizer app
//
//  Created by Shashank Yadav on 27/09/25.
//

import SwiftUI

struct OrderConformationScreen: View {
    @EnvironmentObject var order:Order
    @State private var isProcessing  = true
    @State private var showSuccess = false
    var body: some View {
        ZStack {
            if isProcessing {
                ProgressView("Processing your order ")
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
                    
                    Button("back to button"){
                        order.clear()
                    }
                    .buttonStyle(.borderedProminent)
                    
                    
                    
                }
            }
            
        }
        .onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now()+2){   // means this may take time current threqad doesnot stops working
                                                                // means it will display the screen after the 2 seconds of the current instance of the time
                
                withAnimation{
                    
                }
                
            }
        }
    }
    
}

#Preview {
    OrderConformationScreen()
     .environmentObject(Order())
}
