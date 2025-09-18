//
//  AppetizerlistCell1.swift
//  Appetizer app
//
//  Created by Shashank Yadav on 10/09/25.
//

import SwiftUI

struct AppetizerlistCell1: View {
    let appetizer:Appetizer
    var body: some View {
        HStack {
            /*AsyncImage(url: URL(string: appetizer.imageURL)){ image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
               
                ProgressView()
            }
            .frame(width: 120, height: 120)*/
            
            AsyncImage(url: URL(string: appetizer.imageURL)) { phase in  // in this url is converted into url oso it converti into the url and assign the valid url then we use the url through the url object
                switch phase {  //it represent current phase of the image
                case .empty:    // by downloading the image if it is empty then display loading
                    ProgressView()
                        .frame(width: 120, height: 120)
                case .success(let image):   // success then display the image
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 120, height: 120)
                        .clipped()
                        .cornerRadius(5)
                case .failure(_):
                    Image(systemName: "photo")  // Fallback image in case of failure
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 120, height: 120)
                @unknown default:
                    EmptyView()
                }
            }
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
    AppetizerlistCell1(appetizer: MockData.sampleAppetizer)
}

