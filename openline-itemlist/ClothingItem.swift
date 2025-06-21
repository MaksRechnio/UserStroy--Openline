import SwiftUI


struct ClothingItem: Codable {
    let imageName: String
    let title: String
    let description: String
    let author: String
}


func save(items: [ClothingItem]) {
    if let data = try? JSONEncoder().encode(items) {
        UserDefaults.standard.set(data, forKey: "items")
    }
}

func load() -> [ClothingItem]? {
    if let data = UserDefaults.standard.data(forKey: "items"),
       let items = try? JSONDecoder().decode([ClothingItem].self, from: data) {
        return items
    }
    return nil
}
