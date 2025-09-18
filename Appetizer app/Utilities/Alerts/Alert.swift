//
//  Alert.swift
//  Appetizer app
//
//  Created by Shashank Yadav on 06/09/25.
//

import SwiftUI

struct AlertItem:Identifiable {
    let id = UUID()
    let Title:Text
    let message:Text
    let dissmedButton:Alert.Button
    
}

struct AlertContext {
    
    // ~
    static let invalidData = AlertItem(Title: Text("Server Error "),
                                       message: Text("The data recived from the server is invalid. Plaese contact the support. "),
                                       dissmedButton: .default(Text("OK")))
    static let invalidResponse =  AlertItem(Title: Text("Server Error "),
                                            message: Text("The data recived from the server is invalid. Plaese contact the support. "),
                                            dissmedButton: .default(Text("OK")))
    
    static let inavlidURL = AlertItem(Title: Text("Server Error"),
                                      message: Text("There is an issue with connecting to the server . If this persists, please come contact support ."),
                                      dissmedButton: .default(Text("OK")))
    
    static let unableToComplete = AlertItem(Title: Text("Server Error"),
                                            message: Text("unable to complete the request at that time.="),
                                            dissmedButton: .default(Text("OK")))
    
   // ~ Accounts Alerts
    static let invalidemailId = AlertItem(Title: Text("Invalid Email"), message: Text("There is an issue with email address"), dissmedButton: .default(Text("ok")))
    
    static let invalidForm = AlertItem(Title: Text("inavlid Form"), message: Text("Please ensure that all fields in the form are filled "), dissmedButton: .default(Text("ok")))
    
    
    // ~ encoding in Alert
    
    static let savedSuccess = AlertItem(Title: Text("Profile Saved Successfully"), message: Text("the data have been saved successfully"), dissmedButton: .default(Text("ok")))
    
    static let errorsaving = AlertItem(Title: Text("Profile Error"), message: Text("There is an issue in saving  your profile "), dissmedButton: .default(Text("ok")))
    
    
}
