//
//  ContentView.swift
//  ShoppingList
//
//  Created by Kostya on 30.09.2026.
//

import SwiftUI
import SwiftData

var DEVMODE = true
struct ContentView: View {
    @State private var items:[ShoppingItem] = DEVMODE ? ShoppingItem.samples: []
    @State private var searchText = ""
    @State private var showingAddItem = false
    @State var availableCategories:[Category] = [
        Category(name: "Дом", color: .orange),
        Category(name: "Продукты", color: .green),
        Category(name: "Учёба", color: .blue),
    ]
    
    private var visibleItems:[ShoppingItem] {
        guard !searchText.isEmpty else{return items}
        return items.filter({
            $0.category.name.localizedCaseInsensitiveContains(searchText)
            ||
            $0.name.localizedCaseInsensitiveContains(searchText)
        })
    }
    var body: some View {
        NavigationStack{
            List{
                if visibleItems.isEmpty{
                    ContentUnavailableView.search(text: searchText)
                }
                else{
                    ForEach(visibleItems){item in
                        NavigationLink(value:item.id){
                            ShoppingItemRow(item: item){_toggle(item)}
                        }
                    }.onDelete(perform: _delete)
                }
            }
            .toolbar{
                ToolbarItem{
                    Button("Добавить", systemImage: "plus"){
                        showingAddItem = true
                    }
                }
            }
            .navigationTitle("Покупки")
            .searchable(text:$searchText, prompt: "Категории / Названия")
            .navigationDestination(for: UUID.self) { id in
                if let index = items.firstIndex(where: { $0.id == id }) {
                    ShoppingItemDetailView(categories:$availableCategories, item: $items[index])
                }
            }
            .sheet(isPresented: $showingAddItem){
                AddShoppingItemView(categories:$availableCategories){
                    newItem in items.append(newItem)
                }
            }
        }
    }
    private func _toggle(_ item:ShoppingItem){
        guard let index = items.firstIndex(where: {item.id == $0.id}) else {return}
        items[index].isPurchased.toggle()
    }
    private func _delete(at offsets:IndexSet){
        let ids = offsets.map { visibleItems[$0].id }
        items.removeAll { ids.contains($0.id)}
    }
}

#Preview {
    ContentView()
}
