//
//  AppetizerViewModel.swift
//  Appetizer app
//
//  Created by Shashank Yadav on 05/09/25.
//

import SwiftUI                                                                      // it follows the MVVM Structure here view model will handel the network request and hwo the veiw will look like
final class AppetizerViewModel: ObservableObject {                                  // it will notify the changes
    @Published  var appetizers:[Appetizer] = []
    @Published var alertItem:AlertItem?
    @Published var isloading = false
    @Published var isShowingDetailView = false
    @Published var selectedAppetizer:Appetizer?
    func getAppetizer() {                                                           // it will get the appetizer data through the network manager
        isloading = true
        NetworkManager.shared.getAppetizers { result in                             // network manager will return the the data through the json
            
            DispatchQueue.main.asyncAfter(deadline: .now()+2)  {
                self.isloading = false
                switch result {                                                         // now we give this appetixer data as it will  notify the change to the         D
                    //       @stateobject we use this when we want change
                case .success(let appetizers):
                    self.appetizers = appetizers
                    
                case .failure(let error):
                    switch error {
                    case .invalidResponse:
                        self.alertItem = AlertContext.invalidResponse
                        
                    case .invalidURL:
                        self.alertItem = AlertContext.inavlidURL
                    case .invalidData:
                        self.alertItem = AlertContext.invalidData
                    case .unableToComplete:
                        self.alertItem = AlertContext.unableToComplete
                    }
                }
            }
        }
    }
}
