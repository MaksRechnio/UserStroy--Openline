import SwiftUI

struct EditItemView: View {
    @Environment(\.dismiss) var dismiss
    var item: ClothingItem
    var onEdit: (ClothingItem) -> Void
    var onDelete: () -> Void

    // MARK: - Input States
    @State private var selectedIndex = 0
    @State private var title = ""
    @State private var description = ""

    let clothingImages = [
        "openline-tshirt-yellow",
        "openline-sundress-beige",
        "openline-boxers-blue",
        "openline-pants-mint",
        "openline-hoodie-purple",
        "openline-coat-red"
    ]
    
    init(item: ClothingItem, onEdit: @escaping (ClothingItem) -> Void, onDelete: @escaping () -> Void) {
        self.item = item
        self.onEdit = onEdit
        self.onDelete = onDelete

        _title = State(initialValue: item.title)
        _description = State(initialValue: item.description)
        _selectedIndex = clothingImages.count > 0 ? State(initialValue: clothingImages.firstIndex(of: item.imageName) ?? 0) : State(initialValue: 0)
    }

    var body: some View {
        VStack(spacing: 16) {
            // Header with cancel and save buttons
            HStack {
                Button(action: {
                    onDelete()
                    dismiss()
                }) {
                    Text("Delete")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(Color(.red))
                        .cornerRadius(8)
                }.padding()
                Spacer()

                Button(action: {
                    let newItem = ClothingItem(
                        imageName: clothingImages[selectedIndex],
                        title: title,
                        description: description,
                        author: item.author
                    )
                    onEdit(newItem)
                    dismiss()
                }) {
                    Text("Edit")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(Color(.green))
                        .cornerRadius(8)
                }
                .disabled(title.isEmpty || description.isEmpty)
                .opacity(title.isEmpty || description.isEmpty ? 0.4 : 1.0)
                .padding()
            }

            // Clothing selector
            Text("Clothing type:")
                .font(.headline)
                .foregroundColor(.black)
                

            HStack {
                Button(action: {
                    withAnimation {
                        selectedIndex = (selectedIndex - 1 + clothingImages.count) % clothingImages.count
                    }
                }) {
                    Image("arrow-icon")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .rotationEffect(.degrees(180))
                }

                Spacer()

                Image(clothingImages[selectedIndex])
                    .resizable()
                    .scaledToFit()
                    .frame(height: 120)

                Spacer()

                Button(action: {
                    withAnimation {
                        selectedIndex = (selectedIndex + 1) % clothingImages.count
                    }
                }) {
                    Image("arrow-icon")
                        .resizable()
                        .frame(width: 24, height: 24)
                }
            }
            .padding(.horizontal, 32)

            // Title input
            VStack(alignment: .leading, spacing: 4) {
                Text("Title:")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                TextField("Summarise your opinion into a topic", text: $title)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
            }
            .padding(.horizontal)

            // Description input
            VStack(alignment: .leading, spacing: 4) {
                Text("Description")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                TextEditor(text: $description)
                    .frame(height: 100)
                    .padding(4)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .overlay(
                        Group {
                            if description.isEmpty {
                                Text("Elaborate on the context of your opinion")
                                    .foregroundColor(.gray)
                                    .padding(8)
                                    .allowsHitTesting(false)
                            }
                        }, alignment: .topLeading
                    )
            }
            .padding(.horizontal)

            Spacer()
        }
        .padding(.top)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
                .shadow(radius: 8)
        )
    }
}




//import SwiftUI
//
//struct NewItemView: View {
//    @State private var title = ""
//    @State private var description = ""
//    @State private var imageType = "System"
//    @State private var imageName = ""
//
//    var onAdd: (TodoItem) -> Void
//    @Environment(\.dismiss) private var dismiss
//
//    var body: some View {
//        NavigationView {
//            Form {
//                Section(header: Text("Details")) {
//                    TextField("Title", text: $title)
//                    TextField("Description", text: $description)
//                }
//
//                Section(header: Text("Image")) {
//                    Picker("Image Type", selection: $imageType) {
//                        Text("System").tag("System")
//                        Text("Asset").tag("Asset")
//                    }
//                    .pickerStyle(SegmentedPickerStyle())
//
//                    TextField("Image Name", text: $imageName)
//                }
//            }
//            .navigationTitle("Create a new task")
//            .toolbar {
//                ToolbarItem(placement: .confirmationAction) {
//                    Button("Add") {
//                        guard !title.isEmpty, !imageName.isEmpty else { return }
//
//                        let imageSource: TodoItem.ImageSource = (imageType == "System")
//                            ? .system(imageName)
//                            : .asset(imageName)
//
//                        let newItem = TodoItem(
//                            title: title,
//                            description: description,
//                            imageSource: imageSource
//                        )
//
//                        onAdd(newItem)
//                        dismiss()
//                    }
//                }
//
//                ToolbarItem(placement: .cancellationAction) {
//                    Button("Cancel", role: .cancel) {
//                        dismiss()
//                    }
//                }
//            }
//        }
//    }
//}
