//
//  User_App Storage.swift
//  Appetizer app
//
//  Created by Shashank Yadav on 16/09/25.
//

import Foundation
struct User: Codable {
   var  firstName             = ""
   var  lastName              = ""
   var  email                 = ""
   var  birthdate             = Date() // in this Date is used because we want to strore teh value where as the date picker is the UI control  view that      var                                         allow user to pick the date
   var extraNapkin            = false
   var frequentRefills        = false
    
}

