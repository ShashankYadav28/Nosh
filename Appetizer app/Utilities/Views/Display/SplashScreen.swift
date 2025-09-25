//
//  SplashScreen.swift
//  Appetizer app
//
//  Created by Shashank Yadav on 20/09/25.
//

import SwiftUI

struct SplashScreen: View {
    @Binding var showSplash:Bool

    @State private var isActive = false
    @State private var logoOpacity  = 0.0
    @State private var textOpacity = 0.0
    @State private var logoScale:CGFloat  = 0.0
    @State private var splashOpacity = 1.0
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.white,.black,Color("lightBlue")]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea(.all)
            
            RadialGradient(gradient: Gradient(colors:[Color.white.opacity(0.3),Color.clear]),center: .center, startRadius: 20, endRadius: 200)
                .blendMode(.overlay)
            
            VStack{
                Text("Nosh")
                    .font(.system(size: 40,weight:.bold,design: .rounded))
                    .foregroundColor(.white)
                    .scaleEffect(logoScale)
                    .opacity(logoOpacity)
                    .shadow(color: .black.opacity(0.3), radius: 10,x:0,y:5)
                
                Text("Eat. Share. Discover.")
                    .font(.system(size: 20,weight: .medium,design: .rounded))
                    .foregroundColor(.white.opacity(0.85))
                    .opacity(textOpacity)
            }
        }
        .opacity(splashOpacity)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now()+0.3){
                withAnimation(.spring(response: 0.7, dampingFraction: 0.7)) {
                    logoScale = 1.0
                    logoOpacity = 1.0
                }
            }
            withAnimation(.easeIn(duration: 1.0).delay(0.8)){
                textOpacity = 1.0
            }
            DispatchQueue.main.asyncAfter(deadline: .now()+2.5 ){
                withAnimation(.easeOut(duration: 1.0)){
                    splashOpacity = 0
                    logoOpacity = 0
                    logoScale = 0
                }
                DispatchQueue.main.asyncAfter(deadline: .now()+1.0){
                    showSplash = false
                    
                }
            }
        }
    }
}

#Preview {
    SplashScreen(showSplash:.constant(true))
}
