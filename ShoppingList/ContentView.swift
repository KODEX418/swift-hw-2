//
//  ContentView.swift
//  ShoppingList
//
//  Created by Kostya on 30.09.2026.
//

import SwiftUI

enum StatusFilterMode:String, CaseIterable{
    case Bought="Купленное", All="Всё", NeedToBuy="Не купленное"
}

enum SortMode:String, CaseIterable{
    case ByName="По имени", ByCategory="По категории", ByAmount="По количеству"
}

var DEVMODE = true

struct ContentView: View {
    @State private var items:[ShoppingItem] = DEVMODE ? ShoppingItem.samples: []
    @State private var statusFilterMode:StatusFilterMode = .All
    @State private var sortMode:SortMode = .ByAmount
    @State private var searchText = ""
    @State private var showingAddItem = false
    @State var availableCategories:[Category] = [
        Category(name: "Дом", color: .orange),
        Category(name: "Продукты", color: .green),
        Category(name: "Учёба", color: .blue),
    ]
    @State private var sortModeOrderIsAscending = true
    private var visibleItems:[ShoppingItem] {
        let sortingClosure: (ShoppingItem, ShoppingItem) -> Bool = {s1, s2 in
                let res:Bool
                if sortMode == .ByName{
                    res = s1.name.localizedLowercase < s2.name.localizedLowercase
                }
                else if sortMode == .ByAmount{
                    res = s1.quantity > s2.quantity
                }
                else{
                    res = (s1.category.name.localizedLowercase, s1.name.localizedLowercase) < (s2.category.name.localizedLowercase, s2.name.localizedLowercase)
                }
                return res
            }
        let items = items.filter({
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
        .sorted(by:sortingClosure)
        return sortModeOrderIsAscending ? items : Array(items.reversed())
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
                ToolbarItem(placement:.topBarLeading){
                    Menu{
                    Picker("",selection: $sortMode ){
                        ForEach(SortMode.allCases, id:\.self) {mode in
                            Text(mode.rawValue).tag(mode)
                        }
                    }
                        Picker("", selection: $sortModeOrderIsAscending){
                            Text("По возрастанию").tag(true)
                            Text("По убыванию").tag(false)
                        }
                    } label: {Image(systemName: "arrow.up.arrow.down")}
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
