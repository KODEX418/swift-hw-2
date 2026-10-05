//
//  CategoryPickerView.swift
//  ShoppingList
//
//  Created by Kostya on 04.10.2026.
//

import SwiftUI

struct CategoryPickerView: View {
    @Binding var categories:[Category]
    @Binding var currentCategory:Category
    @State private var tempCategory:Category?
    @State var newCategoryName:String = ""
    @State var newCategoryColor:Color = .gray
    @State private var showingAddSheet = false
    
    private static let addNewTag = Category(name: "Добавить категорию", color: .gray)
    
    var body: some View {
            Picker("Категория", selection: $currentCategory){
                Text(Category.Null.name)
                    .tag(Category.Null)
                    .foregroundStyle(Category.Null.color)
                Divider()
                ForEach(categories){category in
                    Text(category.name)
                    .tag(category)
                    .foregroundStyle(category.color)
                }
                Divider()
                Text(CategoryPickerView.addNewTag.name)
                    .tag(CategoryPickerView.addNewTag)
                    .foregroundStyle(CategoryPickerView.addNewTag.color)
            }
            .tint(currentCategory.color)
            .pickerStyle(.menu)
            .onChange(of: currentCategory){oldValue, newValue in
                switch newValue{
                case CategoryPickerView.addNewTag:
                    tempCategory = oldValue
                    showingAddSheet = true
                default:
                    tempCategory = oldValue
                }
            }
            .labelsHidden()
            .sheet(isPresented: $showingAddSheet){
                NavigationStack{
                    Form{
                        TextField("Название категории", text: $newCategoryName)
                        ColorPicker("Цвет категории", selection: $newCategoryColor)
                    }
                    .navigationTitle("Создать категорию")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar{
                        ToolbarItem(placement: .cancellationAction){
                            Button("Отмена", role: .cancel){
                                guard let tempCategory else {return}
                                currentCategory = tempCategory
                                showingAddSheet = false
                            }
                        }
                        ToolbarItem(placement:.confirmationAction){
                            Button("Добавить"){
                                let newCategory = Category(name: newCategoryName, color: newCategoryColor)
                                categories.append(newCategory)
                                currentCategory = newCategory
                                showingAddSheet = false
                            }
                            .disabled(newCategoryName.trimmingCharacters(in: .whitespaces).isEmpty)
                        }
                    }
                }
                .presentationDetents([.fraction(0.85)])
                .ignoresSafeArea(.keyboard)
        }
            
//        .confirmationDialog("Удалить категорию", isPresented: $showingRemoveSheet){
//            ForEach(categories){
//                
//            }
//            Button("Отмена", role: .cancel){
//                guard let tempCategory else {return}
//                currentCategory = tempCategory
//                showingRemoveSheet = false
//            }
//            Button("Удалить"){
//                
//            }
        }
}
