//
//  AccountView.swift
//  Appetizer app
//
//  Created by Shashank Yadav on 30/08/25.
//

import SwiftUI

struct AccountView: View {
    @StateObject private var accountViewModel = AccountViewModel()
    @FocusState private var focusedTextField: FormTextField? // it keeps the track of which is focused
                                                            
    
    enum FormTextField {
        case firstName
        case lastName
        case email
        
        
    
    }

    
    var body: some View {
        NavigationView{
            Form { // as we are the using the form it automatically apply the styling that the form will need
                Section { // section is used to group the related                                           contents together
                    
                    TextField("First Name:", text: $accountViewModel.user.firstName)
                        .focused($focusedTextField, equals:.firstName)
                        .onSubmit{
                            focusedTextField = .lastName
                        }
                        .submitLabel(.next)
                    
                    // in this we need to provide the binding which binds the focus of the state adn equals to here is for the case that we have to bind
                    
                    TextField("last Name:", text: $accountViewModel.user.lastName)
                        .focused($focusedTextField, equals:.lastName)
                        .onSubmit {
                            focusedTextField = .email
                        }
                        .submitLabel(.next)
                    
                    TextField("Email:", text: $accountViewModel.user.email)
                        .focused($focusedTextField, equals:.email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .onSubmit {
                            focusedTextField = nil
                        }
                        .submitLabel(.continue
                        )
                       // .focused($focusedTextField, equals:.email)
                    DatePicker("Birthday", selection: $accountViewModel.user.Birthdate, displayedComponents: .date)
                    Button {
                        accountViewModel.saveChanges()
                        
                    }label : {
                        Text("Save Changes")
                    }
                } header: {
                    Text("Personal Info")
                }
                
                Section {
                    Toggle("Extra napkins", isOn: $accountViewModel.user.extraNapkin)
                        .toggleStyle(SwitchToggleStyle(tint: .brandPrimary))
                    
                    
                    Toggle("Frequent Refiils", isOn: $accountViewModel.user.frequentRefills)
                        .toggleStyle(SwitchToggleStyle(tint: .brandPrimary))
                }
                header:  {
                    Text("Requests")
                }
                
            }
            //.environment(\.toggleStyle, SwitchToggleStyle(tint: .brandPrimary)) // this will apply toggle style to each toggle
            .onAppear {
                accountViewModel.retrive()
            }
            .navigationTitle("  Account")
            .alert(item: $accountViewModel.alertItem) { alertItem in
                Alert(title: alertItem.Title, message: alertItem.message, dismissButton: alertItem.dissmedButton)
                
            }
                    
        }
    }
}

#Preview {
    AccountView()
}
