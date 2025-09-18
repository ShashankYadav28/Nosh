//
//  Appetizer.swift
//  Appetizer app
//
//  Created by Shashank Yadav on 04/09/25.
//

import Foundation

struct Appetizer:Codable , Identifiable {
    let id:Int
    let name:String
    let description:String
    let price:Double
    let calories:Int
    let protein:Int
    let carbs:Int
    let imageURL:String
    
}



struct MockData {
    static let sampleAppetizer = Appetizer(id: 1,
                                           name: "Test Appetizer",
                                           description: "We are testing the Appetizer",
                                           price: 12,
                                           calories: 10,
                                           protein: 50,
                                           carbs: 20,
                                           imageURL: "")
    static let appetizer = [sampleAppetizer,sampleAppetizer,sampleAppetizer,sampleAppetizer,sampleAppetizer,sampleAppetizer,sampleAppetizer,sampleAppetizer,sampleAppetizer]
    
    
    static let ordereSampleAppetizerone = Appetizer(id: 1,
                                           name: "Test Appetizer",
                                           description: "We are testing the Appetizer",
                                           price: 12,
                                           calories: 10,
                                           protein: 50,
                                           carbs: 20,
                                           imageURL: "")
    
    static let orderSampleAppetizertwo = Appetizer(id: 2,
                                           name: "Test Appetizer",
                                           description: "We are testing the Appetizer",
                                           price: 12,
                                           calories: 10,
                                           protein: 50,
                                           carbs: 20,
                                           imageURL: "")
    
    static let orderSampleAppetizerThree = Appetizer(id: 3,
                                           name: "Test Appetizer",
                                           description: "We are testing the Appetizer",
                                           price: 12,
                                           calories: 10,
                                           protein: 50,
                                           carbs: 20,
                                           imageURL: "")
    
    static let orderItem  = [ordereSampleAppetizerone,orderSampleAppetizertwo,orderSampleAppetizerThree]
    
    
    
    
    
    
    
}
