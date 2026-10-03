//
//  ShoppingListApp.swift
//  ShoppingList
//
//  Created by Kostya on 30.09.2026.
//

import SwiftUI
import SwiftData

@main
struct ShoppingListApp: App {
    
     static let integerFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.allowsFloats = false
        formatter.minimum = 0
        formatter.maximum = 99
        return formatter
    }()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
