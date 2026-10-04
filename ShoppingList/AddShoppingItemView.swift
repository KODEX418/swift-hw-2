//
//  AddShoppingItemView.swift
//  ShoppingList
//
//  Created by Kostya on 04.10.2026.
//
import SwiftUI

struct AddShoppingItemView:View{
    @Environment(\.dismiss) private var dismiss
    @Binding var categories:[Category]
    let onSave: (ShoppingItem) -> Void
    @State private var quantity = 1
    @State private var name = ""
    @State var currCategory:Category = Category.Null
    var body: some View{
        NavigationStack{
            Form {
                HStack{
                    Text("Название:").font(.headline)
                    Spacer()
                    TextField("", text: $name)
                }
                HStack{
                    Text("Категория:").font(.headline)
                    Spacer()
                    CategoryPickerView(categories: $categories, currentCategory: $currCategory)
                }
                Stepper(value: $quantity, in: 1...99){
                    HStack{
                        Text("Количество:").font(.headline)
                        TextField("", value: $quantity, formatter: ShoppingListApp.integerFormatter)
                    }
                }
            }
            .toolbar(){
                ToolbarItem(placement: .cancellationAction){
                    Button("Отмена"){dismiss()}
                }
                ToolbarItem(placement: .confirmationAction){
                    Button("Сохранить"){
                        onSave(ShoppingItem(name: name.trimmingCharacters(in: .whitespaces), category: currCategory, quantity: quantity))
                        dismiss()
                    }.disabled(name.trimmingCharacters(in: .whitespaces).isEmpty)
                }
            }
            .navigationTitle("Новая покупка")
            .navigationBarTitleDisplayMode(.automatic)
            
        }
    }
}

//#Preview {
//    AddShoppingItemView(onSave: {s1 in })
//}
