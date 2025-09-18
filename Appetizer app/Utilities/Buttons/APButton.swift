//
//  APButton.swift
//  Appetizer app
//
//  Created by Shashank Yadav on 11/09/25.
//

import SwiftUI
struct APButton: View {
    var title:LocalizedStringKey
    
    var body: some View {
        Text(title)
            .font(.title2)
            .fontWeight(.semibold)
            .font(.system(size: 15))
            .minimumScaleFactor(0.5)
            .frame(width:260,height:50)
            .foregroundColor(.white)
            .background(Color(.brandPrimary))
         
        
        
    }
    
    
}
