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
    @State private var showingAddSheet = false
    @State private var clothingItems: [ClothingItem] = [
        ClothingItem(imageName: "openline-tshirt-yellow", title: "Thread of Hope", author: "Jamal Idris"),
        ClothingItem(imageName: "openline-sundress-beige", title: "Woven Words", author: "Leila Nguyen"),
        ClothingItem(imageName: "openline-boxers-blue", title: "Against the Seam", author: "Carlos Romero")
    ]

    var body: some View {
        ClotheslineView(
            items: clothingItems,
            onAdd: {_ in 
                showingAddSheet = true
            }
        )
        .sheet(isPresented: $showingAddSheet) {
            NewItemView(
                onAdd: { item in
                    let newClothingItem = ClothingItem(
                        imageName: {
                            switch item.imageSource {
                            case .system(let name), .asset(let name):
                                return name
                            }
                        }(),
                        title: item.title,
                        author: "Anonymous"
                    )
                    clothingItems.append(newClothingItem)
                    showingAddSheet = false
                }
            )
        }
    }
}
