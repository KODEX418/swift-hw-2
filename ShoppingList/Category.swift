//
//  Category.swift
//  ShoppingList
//
//  Created by Kostya on 04.10.2026.
//
import Foundation
import SwiftUI

extension Color {
    var rgb: (red: Double, green: Double, blue: Double, alpha: Double) {
        let uiColor = UIColor(self)
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        uiColor.getRed(&r, green: &g, blue: &b, alpha: &a)
        return (Double(r), Double(g), Double(b), Double(a))
    }
}
struct Category:Identifiable, Hashable, Codable{
    var id = UUID()
    let name:String
    var r, g, b: Double
    var color: Color{
        return Color(red:r,green:g,blue:b)
    }
    init(name: String, color:Color) {
        self.name = name
        r = color.rgb.red
        g = color.rgb.green
        b = color.rgb.blue
    }
}

extension Category{
    static let Null = Category(name: "Без категории", color: .gray)
}
