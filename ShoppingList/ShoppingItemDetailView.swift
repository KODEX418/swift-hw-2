//
//  ShoppingItemDetailView.swift
//  ShoppingList
//
//  Created by Kostya on 04.10.2026.
//

import SwiftUI

struct ShoppingItemDetailView: View {
    @Binding var categories:[Category]
    @Binding var item: ShoppingItem
    
    var body: some View{
        Form {
            HStack{
                Text("Название:").font(.headline)
                Spacer()
                TextField("", text: $item.name)
            }
            HStack{
                Text("Категория:").font(.headline)
                CategoryPickerView(categories: $categories, currentCategory: $item.category)
                Spacer()
            }
            Stepper(value: $item.quantity, in: 1...99){
                HStack{
                    Text("Количество:").font(.headline)
                    TextField("", value: $item.quantity, formatter: ShoppingListApp.integerFormatter)
                }
            }
            Toggle(isOn: $item.isPurchased){
                Text("Куплено: ").font(.headline)
            }
        }
    }
}
//#Preview {
//    ShoppingItemDetailView(item: ShoppingItem.samples[0])
//}
