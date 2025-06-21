import SwiftUI

@main
struct openline_itemlistApp: App {
    var body: some Scene {
        WindowGroup {
            MainClotheslineWrapper()
        }
    }
}

struct MainClotheslineWrapper: View {
    @State private var clothingItems: [ClothingItem] = []
    
    init() {
        _clothingItems = .init(wrappedValue: load() ?? [
            ClothingItem(imageName: "openline-tshirt-yellow", title: "Thread of Hope",description: "desc", author: "Jamal Idris"),
            ClothingItem(imageName: "openline-sundress-beige", title: "Woven Words", description: "", author: "Leila Nguyen"),
            ClothingItem(imageName: "openline-boxers-blue", title: "Against the Seam", description: "", author: "Carlos Romero"),
            ClothingItem(imageName: "openline-pants-mint", title: "Aleikum of Hope", description: "", author: "Maud Leyley"),
            ClothingItem(imageName: "openline-hoodie-purple", title: "Brr Brr patapim Words", description: "", author: "Luke Skywalker"),
            ClothingItem(imageName: "openline-coat-red", title: "Isreal Against the Seam", description: "", author: "Pookie Wookie")
        ])
    }

    var body: some View {
        ClotheslineView(
            items: clothingItems,
            onAdd: {item in
                clothingItems.append(item)
                save(items: clothingItems)
            },
            onEdit: {
                (item, i) in
                clothingItems[i] = item
                save(items: clothingItems)
            },
            onDelete: {i in
                clothingItems.remove(at: i)
                save(items: clothingItems)
            },
        )
    }
}
