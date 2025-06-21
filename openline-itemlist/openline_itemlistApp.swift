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
            ClothingItem(imageName: "openline-tshirt-yellow", title: "Remote Work Forever",description: "Companies that force employees back into the office are ignoring how productive and balanced remote work can be.", author: "Jamal Idris"),
            ClothingItem(imageName: "openline-sundress-beige", title: "Ban Microplastics", description: "The long-term environmental damage of microplastics outweighs the convenience they provide in products like cosmetics and clothes.", author: "Leila Nguyen"),
            ClothingItem(imageName: "openline-boxers-blue", title: "AI Shouldn’t Replace Art", description: "AI can be a tool for creativity, but using it to mass-produce art devalues human emotion and expression in the creative process.", author: "Carlos Romero"),
            ClothingItem(imageName: "openline-pants-mint", title: "Fast Fashion Must Go", description: "It’s unethical to support brands that exploit workers and the environment just to sell cheap, disposable clothes.", author: "Maud Leyley"),
            ClothingItem(imageName: "openline-hoodie-purple", title: "No More Grading", description: "Traditional grades don’t reflect real learning. Education systems should focus on feedback and growth, not numbers and letters.", author: "Luke Skywalker"),
            ClothingItem(imageName: "openline-coat-red", title: "Universal Basic Income Works", description: "Pilot programs show that a basic income improves mental health, productivity, and doesn’t reduce motivation to work.", author: "Pookie Wookie")
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
