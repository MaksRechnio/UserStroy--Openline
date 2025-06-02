import SwiftUI

struct NewItemView: View {
    @State private var title = ""
    @State private var description = ""
    @State private var imageType = "System"
    @State private var imageName = ""

    var onAdd: (TodoItem) -> Void
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationView {
            Form {
                TextField("Title", text: $title)
                TextField("Description", text: $description)

                Picker("Image Type", selection: $imageType) {
                    Text("System").tag("System")
                    Text("Asset").tag("Asset")
                }

                TextField("Image Name", text: $imageName)
            }
            .navigationTitle("Create a new task")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add") {
                        let imageSource: TodoItem.ImageSource = (imageType == "System")
                            ? .system(imageName)
                            : .asset(imageName)

                        let newItem = TodoItem(title: title, description: "", imageSource: imageSource)
                        onAdd(newItem)
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
    }
}
