//
//  SplashScreen.swift
//  Appetizer app
//
//  Created by Shashank Yadav on 20/09/25.
//

import SwiftUI

struct SplashScreen: View {
    @State  private var isActive = false
    @State private var opacity  = 0.5
    @State private var scale:CGFloat  = 0.6
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color("warmBiege"),Color("softorange"),Color("lightBlue")]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea(.all)
            
            VStack{
                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width:250,height:250)
                    .scaleEffect(scale)
                    .opacity(opacity)
                    .shadow(color: .black.opacity(0.3), radius: 10,x:0,y:5)
                    .onAppear{
                        withAnimation(.easeInOut(duration: 1.5)) {   // it will scale and increase the opacity to                                               1.0 and 1.0  till the animation suration                                                reaches 1.5
                            
                            scale  = 1.0
                            opacity  = 1.0
                        }
                    }
                
                Text("Nosh")
                    .font(.system(size: 32,weight: .bold,design: .rounded))
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
}

#Preview {
    SplashScreen()
}
