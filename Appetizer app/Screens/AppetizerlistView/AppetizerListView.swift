//
//  AppetizerListView.swift
//  Appetizer app
//
//  Created by Shashank Yadav on 30/08/25.
//

import SwiftUI

struct AppetizerListView: View {
    
    // @State private var appetizers:[Appetizer] = []
    
    @StateObject var viewModel = AppetizerViewModel()
  
    
   // @StateObject var isloading
    
    var body: some View {
        ZStack {
            NavigationView {
                List(viewModel.appetizers){ appetizer in
                    AppetizerListCell(appetizer: appetizer)
                        .onTapGesture {
                            viewModel.isShowingDetailView = true
                            viewModel.selectedAppetizer = appetizer
                        }
                       /* .fullScreenCover(isPresented: $viewModel.isShowingDetailView, content: {
                            AppetizerDetailView(appetizer: viewModel.selectedAppetizer ?? MockData.sampleAppetizer, isShowingDetailView: $viewModel.isShowingDetailView)
                        })*/
                }
                .blur(radius: viewModel.isShowingDetailView ? 20 : 0)
                .disabled(viewModel.isShowingDetailView)
                
                .navigationTitle("🍿 Appetizers")
               
                
            }
          //  .blur(radius: isShowingDetailView ? 20 : 0)
            .onAppear() {
                viewModel.getAppetizer()
            }
           
           if viewModel.isShowingDetailView {
                AppetizerDetailView(appetizer: viewModel.selectedAppetizer ?? MockData.sampleAppetizer, isShowingDetailView: $viewModel.isShowingDetailView)
            }
            
            
            
            if (viewModel.isloading){
                LoadingView()
            }
            
            
        }
        .alert(item: $viewModel.alertItem){ alertItem in
            Alert(title: alertItem.Title,message: alertItem.message,dismissButton: alertItem.dissmedButton)
            
        }
    }
}

#Preview {
    AppetizerListView()
}
