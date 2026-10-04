//
//  Category.swift
//  ShoppingList
//
//  Created by Kostya on 04.10.2026.
//
import Foundation
import SwiftUI

struct Category:Identifiable, Hashable{
    let id = UUID()
    let name:String
    let color:Color
    init(name: String, color: Color = .gray) {
        self.name = name
        self.color = color
    }
}

extension Category{
    static let Null = Category(name: "без категории", color: .gray)
}
