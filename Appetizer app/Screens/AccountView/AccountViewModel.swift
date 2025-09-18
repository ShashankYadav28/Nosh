//
//  AccountViewModel.swift
//  Appetizer app
//
//  Created by Shashank Yadav on 16/09/25.
//

import SwiftUI
final class AccountViewModel: ObservableObject {
    @AppStorage("user") private var userData: Data?
    
    @Published var user = User()
    @Published var alertItem:AlertItem?
    
    func saveChanges() {
        guard isValidForm else {  // this line triggers the computed property if there is an error alert item is set and returnn false                                                              as the alert item is set it displays  the error
                                     
            return
        }
        
        
        do {
            let data = try JSONEncoder().encode(user)  // encode save the structured data  (like in userdefault)(in json form )
            userData = data
            alertItem = AlertContext.savedSuccess
        }
        catch {
            alertItem = AlertContext.errorsaving
        }
    }
    
    
    func retrive() {
        guard let userData = userData else {
            return
        }
       
        do {
            user = try JSONDecoder().decode(User.self, from: userData)  // decode is used for loading the saved data and converting the json format data to user object
            
            
        }
        catch {
            alertItem = AlertContext.invalidData
        }
    }
    
    
    var isValidForm: Bool{
        guard !user.firstName.isEmpty && !user.lastName.isEmpty && !user.email.isEmpty else {    // in this isinvalidForm is a computed propertv which runs                                                                                              whenever ever the block is acccessed
        
            alertItem = AlertContext.invalidForm
            return false
            
        }
        guard user.email.isValid else  {
            alertItem = AlertContext.invalidemailId
            return false
        }
        return true
        
    }
    
   
}
