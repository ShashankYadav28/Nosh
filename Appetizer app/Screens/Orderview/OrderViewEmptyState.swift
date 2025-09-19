//
//  OrderViewEmptyState.swift
//  Appetizer app
//
//  Created by Shashank Yadav on 19/09/25.
//

import SwiftUI

struct OrderViewEmptyState: View {
    
    var imageName:String
    var message:String
    
    var body: some View {
        ZStack {
            Color(.systemBackground)
                .ignoresSafeArea(.all)
            VStack {
                Image("\(imageName)")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height:200)
                Text("\(message)")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .fontDesign(.rounded)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)
            }
        }
        .offset(y:-30)  // it will push the stack bit upwards
    }
}

#Preview {
    OrderViewEmptyState(imageName: "empty-order", message: "This is our test message.I am making it is a little long for testing. i want to check if it is working fine or not")
        .environmentObject(Order())
}
