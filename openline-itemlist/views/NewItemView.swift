import SwiftUI

struct NewItemView: View {
    @State private var title = ""
    @State private var description = ""
    @State private var imageType = "System"
    @State private var imageName = ""

    var onAdd: (TodoItem) -> Void
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Details")) {
                    TextField("Title", text: $title)
                    TextField("Description", text: $description)
                }

                Section(header: Text("Image")) {
                    Picker("Image Type", selection: $imageType) {
                        Text("System").tag("System")
                        Text("Asset").tag("Asset")
                    }
                    .pickerStyle(SegmentedPickerStyle())

                    TextField("Image Name", text: $imageName)
                }
            }
            .navigationTitle("Create a new task")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add") {
                        guard !title.isEmpty, !imageName.isEmpty else { return }

                        let imageSource: TodoItem.ImageSource = (imageType == "System")
                            ? .system(imageName)
                            : .asset(imageName)

                        let newItem = TodoItem(
                            title: title,
                            description: description,
                            imageSource: imageSource
                        )

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
