import SwiftUI

// this is the model for a clothing item — I store info about each one
struct ClothingItem: Codable { // Codable so I can save/load it easily
    let imageName: String     // this is the name of the image in assets
    let title: String         // the opinion title
    let description: String   // more context for the opinion
    let author: String        // who created this item
}

// function to save an array of clothing items
func save(items: [ClothingItem]) {
    // try to convert the items into JSON data
    if let data = try? JSONEncoder().encode(items) {
        // store that data in UserDefaults so it sticks around
        UserDefaults.standard.set(data, forKey: "items")
    }
}

// function to load saved clothing items from UserDefaults
func load() -> [ClothingItem]? {
    // try to get the saved data from UserDefaults
    if let data = UserDefaults.standard.data(forKey: "items"),
       let items = try? JSONDecoder().decode([ClothingItem].self, from: data) {
        // if decoding works, return the items
        return items
    }
    // return nil if anything goes wrong
    return nil
}
