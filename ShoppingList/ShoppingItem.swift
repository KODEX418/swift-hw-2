//
//  ShoppingItem.swift
//  ShoppingList
//
//  Created by Kostya on 30.09.2026.
//
import Foundation
struct ShoppingItem:Identifiable, Hashable{
    let id:UUID
    var name:String
    var category:String
    var quantity:Int
    var isPurchased:Bool
    
    init(id: UUID=UUID(), name: String, category: String, quantity: Int=1, isPurchased: Bool=false) {
        self.id = id
        self.name = name
        self.category = category
        self.quantity = quantity
        self.isPurchased = isPurchased
    }
    
}
extension ShoppingItem{
    static let samples = [
        ShoppingItem(name: "Хлеб", category:"Продукты", isPurchased: true),
        ShoppingItem(name: "Молоко", category: "Продукты"),
        ShoppingItem(name: "Ручки", category:"Учеба", quantity: 5),
        ShoppingItem(name: "Батарейки", category:"Дом", quantity: 3)
    ]
}
