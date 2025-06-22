import SwiftUI

// this is the main entry point of my app
@main
struct openline_itemlistApp: App {
    var body: some Scene {
        WindowGroup {
            MainClotheslineWrapper() // this is the main view that wraps the clothesline stuff
        }
    }
}

// this struct manages the full list of items and passes them into the UI
struct MainClotheslineWrapper: View {
    @State private var clothingItems: [ClothingItem] = [] // this holds all my clothing items (opinions)

    init() {
        // when the view is created, I load from storage if possible, otherwise use default data
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
            items: clothingItems, // I pass in the list to the UI
            onAdd: { item in // when something new is added
                clothingItems.append(item)
                save(items: clothingItems) // save to storage
            },
            onEdit: { item, i in // when an item is edited
                clothingItems[i] = item
                save(items: clothingItems)
            },
            onDelete: { i in // when something is deleted
                clothingItems.remove(at: i)
                save(items: clothingItems)
            }
        )
    }
}
