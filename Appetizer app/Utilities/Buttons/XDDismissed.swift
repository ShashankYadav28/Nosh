//
//  XDDismissed.swift
//  Appetizer app
//
//  Created by Shashank Yadav on 12/09/25.
//

import SwiftUI

struct XDDismissed: View  {
    
    var body: some View {
        ZStack{
            Circle()
                .foregroundColor(.white)
                .frame(width: 30,height:40)
                .opacity(0.66)
            
            Image(systemName: "xmark")
                .imageScale(.medium)
                .frame(width: 40,height: 40)
                .foregroundColor(.black)
                
        }
        
    }
}
