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
    var category:Category
    var quantity:Int
    var isPurchased:Bool
    
    init(id: UUID=UUID(), name: String, category: Category = Category.Null, quantity: Int=1, isPurchased: Bool=false) {
        self.id = id
        self.name = name
        self.category = category
        self.quantity = quantity
        self.isPurchased = isPurchased
    }
    
}
extension ShoppingItem{
    static let samples = [
        ShoppingItem(name: "Хлеб",isPurchased: true),
        ShoppingItem(name: "Молоко"),
        ShoppingItem(name: "Ручки", quantity: 5),
        ShoppingItem(name: "Батарейки", quantity: 3)
    ]
}
