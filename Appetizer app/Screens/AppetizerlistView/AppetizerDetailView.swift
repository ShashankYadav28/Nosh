//
//  AppetizerDetailView.swift
//  Appetizer app
//
//  Created by Shashank Yadav on 10/09/25.
//

import SwiftUI

struct AppetizerDetailView: View {
    let appetizer:Appetizer
    @Binding var isShowingDetailView:Bool
    var body: some View {
        VStack {
            AppetizerRemoteImage(imageURL: appetizer.imageURL)
               // .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width:325,height:225)
                .clipped()
                
            // Spacer()
            
            Text(appetizer.name)
                .font(.title2)
                .fontWeight(.bold)
            Text(appetizer.description)
                .font(.body)
                .padding()
            
            HStack(spacing:20){
                VStack(spacing:5){
                    Text("Calories")
                        .font(.caption)
                        .fontWeight(.bold)
                    Text("\(appetizer.calories)")
                        .foregroundColor(.secondary)
                        .fontWeight(.semibold)
                        .italic()
                    
                }
                
                VStack(spacing:5){
                    Text("carbs")
                        .font(.caption)
                        .fontWeight(.bold)
                    Text("\(appetizer.carbs)")
                        .foregroundColor(.secondary)
                        .fontWeight(.semibold)
                        .italic()
                    
                }
                
                VStack(spacing:5){
                    Text("Protein")
                        .font(.caption)
                        .fontWeight(.bold)
                    Text("\(appetizer.protein)")
                        .foregroundColor(.secondary)
                        .fontWeight(.semibold)
                        .italic()
                    
                }
                
            }
            
           // text
            
            Spacer()
            
            Button {
                print("button dismissed")
                
            }
            label:{
              APButton(title: "$\(appetizer.price,specifier: "%.2f") - Add To Order")
                
            }
            .padding(.bottom,30)
            
            
            
        }
        .frame(width:320,height:525)
        .background(Color(.systemBackground))
        .cornerRadius(8)
        .shadow(radius: 40)
        .overlay(Button{
            isShowingDetailView = false
            
        }
        label:{
            XDDismissed()
            
        },alignment: .topTrailing)
    }
}

#Preview {
    AppetizerDetailView(appetizer: MockData.sampleAppetizer, isShowingDetailView: .constant(false))
}
