//
//  ContentView.swift
//  ShoppingList
//
//  Created by Kostya on 30.09.2026.
//

import SwiftUI
import SwiftData


enum StatusFilterMode:String, CaseIterable{
    
    case Bought="Купленное", All="Всё", NeedToBuy="Не купленное"
}

var DEVMODE = false
struct ContentView: View {
    @State private var items:[ShoppingItem] = DEVMODE ? ShoppingItem.samples: []
    @State private var statusFilterMode:StatusFilterMode = .All
    @State private var searchText = ""
    @State private var showingAddItem = false
    @State var availableCategories:[Category] = [
        Category(name: "Дом", color: .orange),
        Category(name: "Продукты", color: .green),
        Category(name: "Учёба", color: .blue),
    ]
    
    private var visibleItems:[ShoppingItem] {
        guard !searchText.isEmpty || statusFilterMode != .All else{return items}
        
        return items.filter({
            (
             statusFilterMode == .All
             ||
             $0.isPurchased == (statusFilterMode == .Bought)
            )
            &&
            (
             searchText.isEmpty
             ||
             $0.category.name.localizedCaseInsensitiveContains(searchText)
             ||
             $0.name.localizedCaseInsensitiveContains(searchText)
            )
            
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
                ToolbarItem(placement:.bottomBar){
                    Picker("", selection: $statusFilterMode){
                        ForEach(StatusFilterMode.allCases, id: \.self){mode in
                            Text(mode.rawValue).tag(mode)
                        }
                    }.pickerStyle(.segmented)
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
                .presentationDetents([.fraction(0.85)])
                .ignoresSafeArea(.keyboard)
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
