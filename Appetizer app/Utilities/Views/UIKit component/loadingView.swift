//
//  loadingView.swift
//  Appetizer app
//
//  Created by Shashank Yadav on 06/09/25.
//

import SwiftUI    // seift ui is used when we want to update the the yu state add text and label wheereas we have to use the foundation when we are working with the networking
// data type array and fileManagement

struct activityIndicator: UIViewRepresentable {
    func makeUIView(context: Context) -> UIActivityIndicatorView {   // make the UIView when needed,you configure initial things here
        let activityIndicatorView = UIActivityIndicatorView(style: .large)                                                          // code is here
        activityIndicatorView.color = UIColor(.brandPrimaryColor)
        activityIndicatorView.startAnimating()
        return activityIndicatorView
        
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {  // it is used when swiftui want to update the view based on the state changes
    }
    
    typealias UIViewType = UIActivityIndicatorView
    // uiview respresentable allows us to use uikit inside the swiftui
}
    
struct LoadingView:View {
        var body: some View {
            ZStack {
                Color(.systemBackground)
                    .edgesIgnoringSafeArea(.all)
                
                activityIndicator()
                
            }
        }
    }

