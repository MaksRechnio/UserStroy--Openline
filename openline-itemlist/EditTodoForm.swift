import SwiftUI

struct EditTodoForm: View {
    @State var todo: TodoItem
    var onSave: (TodoItem) -> Void
    @Environment(\.dismiss) var dismiss

    @State private var imageType: String = "System"

    var body: some View {
        NavigationView {
            Form {
                TextField("Title", text: $todo.title)
                TextField("Description", text: $todo.description)


                Picker("Image Type", selection: $imageType) {
                    Text("System").tag("System")
                    Text("Asset").tag("Asset")
                }

                TextField("Image Name", text: Binding(
                    get: {
                        switch todo.imageSource {
                        case .system(let name): return name
                        case .asset(let name): return name
                        }
                    },
                    set: { newValue in
                        todo.imageSource = (imageType == "System") ? .system(newValue) : .asset(newValue)
                    }
                ))
            }
            .navigationTitle("Edit Task")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        onSave(todo)
                        dismiss()
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", role: .cancel) {
                        dismiss()
                    }
                }
            }
        }
        .onAppear {
            switch todo.imageSource {
            case .system: imageType = "System"
            case .asset: imageType = "Asset"
            }
        }
    }
}
