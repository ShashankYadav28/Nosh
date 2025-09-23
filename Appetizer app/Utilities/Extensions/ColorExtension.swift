//
//  ColorExtension.swift
//  Appetizer app
//
//  Created by Shashank Yadav on 06/09/25.
//

import SwiftUI

extension Color {
    static let brandPrimaryColor = Color("brandPrimary")
    
}

extension UIColor  {
    static let brandPrimaryColor = UIColor(named: "brandPrimary")
}


/*extension Color {
    static let warmBeige = Color(hex: "F5E6D3")
    static let softOrange = Color(hex: "FFA45B")
    static let lightBlue = Color(hex: "6EC6FF")
}*/

extension Color {
    func darker(by percentage: Double = 0.2 )-> Color {
        let uiColor = UIColor(self)
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        
        uiColor.getRed(&r, green: &g, blue: &b, alpha: &a)
        
        return Color(
            red:max(r-CGFloat(percentage),0),
            green:max(g-CGFloat(percentage),0),
            blue:max(r-CGFloat(percentage),0),
            opacity: Double(a)
            
            
        )
    }
}
