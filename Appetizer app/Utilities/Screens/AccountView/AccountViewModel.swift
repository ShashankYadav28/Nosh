//
//  AccountViewModel.swift
//  Appetizer app
//
//  Created by Shashank Yadav on 20/09/25.
//
import SwiftUI

final class AccountViewModel: ObservableObject {
    
    @AppStorage("user") private var userData: Data?
    @Published var user = User()
    @Published var alertItem: AlertItem?
    
    
    func saveChanges() {
        guard isValidForm else { return }
        
        do {
            let data = try JSONEncoder().encode(user)
            userData = data
            alertItem = AlertContext.savedSuccess
        } catch {
            alertItem = AlertContext.errorsaving
        }
    }
    
    
    func retrieveUser() {
        guard let userData else { return }
     //    •    saveChanges() → Encoding:
     //   •    Takes your User struct → converts it to JSON data using JSONEncoder.
     //   •    Stores that JSON data in @AppStorage (i.e., UserDefaults).
     //   •    retrieveUser() → Decoding:
     //   •    Takes the JSON data from @AppStorage → converts it back into a User struct using JSONDecoder.
     //   •    Populates your view model so the UI can show the saved values.

        
        do {
            user = try JSONDecoder().decode(User.self, from: userData)
        } catch {
            alertItem = AlertContext.invalidData
        }
    }
    
    
    var isValidForm: Bool {
        guard !user.firstName.isEmpty && !user.lastName.isEmpty && !user.email.isEmpty else {
            alertItem = AlertContext.invalidForm
            return false
        }
        
        guard user.email.isValid else {
            alertItem = AlertContext.invalidemailId
            return false
        }
        
        return true
    }
    

}

