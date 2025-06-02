import SwiftUI

struct TodoItem: Identifiable, Equatable {
    let id = UUID()
    var title: String
    var description: String
    var imageSource: ImageSource

    enum ImageSource: Equatable {
        case system(String)
        case asset(String)
    }
}
