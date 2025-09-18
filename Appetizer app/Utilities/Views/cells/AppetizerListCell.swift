//
//  AppetizerListCell.swift
//  Appetizer app
//
//  Created by Shashank Yadav on 04/09/25.
//

import SwiftUI

struct AppetizerListCell: View {
    let appetizer:Appetizer
    var body: some View {
        HStack {
            AppetizerRemoteImage(imageURL: appetizer.imageURL)
                .aspectRatio(contentMode: .fill)
                .frame(width:120,height:120)
                .clipped()
                .cornerRadius(8)
            
            VStack(alignment: .leading,spacing: 7){
                Text(appetizer.name)
                    .font(.title2)
                    .fontWeight(.medium)
                Text("$\(appetizer.price,specifier: "%.f")")
                    .foregroundColor(.secondary)
                    .fontWeight(.semibold) 
            }
            .padding(.leading)
        }
    }
}
        
#Preview {
    AppetizerListCell(appetizer:MockData.sampleAppetizer)
}
