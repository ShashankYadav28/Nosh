//
//  SplashScreen.swift
//  Appetizer app
//
//  Created by Shashank Yadav on 20/09/25.
//

import SwiftUI

struct SplashScreen: View {
    @State  private var isActive = false
    var body: some View {
            VStack{
                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width:250,height:250)
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now()+2){
                    withAnimation {
                        isActive = true
                }
            }
        }
    }
}

#Preview {
    SplashScreen()
}
