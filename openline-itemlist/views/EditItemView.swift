import SwiftUI

struct EditItemView: View {
    @Environment(\.dismiss) var dismiss // this lets me close the sheet
    var item: ClothingItem // the item I’m editing
    var onEdit: (ClothingItem) -> Void // callback when I save the edits
    var onDelete: () -> Void // callback if I want to delete this item

    @State private var selectedIndex = 0 // this keeps track of which image is selected
    @State private var title = "" // this is the text field for title
    @State private var description = "" // same for description

    // these are all the image options I can pick from
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

        // pre-fill title and description with what's already in the item
        _title = State(initialValue: item.title)
        _description = State(initialValue: item.description)
        // try to match the current item's image to the list above
        _selectedIndex = clothingImages.count > 0 ? State(initialValue: clothingImages.firstIndex(of: item.imageName) ?? 0) : State(initialValue: 0)
    }

    var body: some View {
        VStack(spacing: 16) {
            // buttons at the top for deleting and saving
            HStack {
                // delete button
                Button(action: {
                    onDelete() // call the delete
                    dismiss()  // and close the sheet
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

                // edit/save button
                Button(action: {
                    // make a new clothing item with the updated values
                    let newItem = ClothingItem(
                        imageName: clothingImages[selectedIndex],
                        title: title,
                        description: description,
                        author: item.author
                    )
                    onEdit(newItem) // call the edit
                    dismiss()       // and close the sheet
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
                .disabled(title.isEmpty || description.isEmpty) // don’t allow save if fields are empty
                .opacity(title.isEmpty || description.isEmpty ? 0.4 : 1.0) // visual feedback
                .padding()
            }

            // image selection label
            Text("Clothing type:")
                .font(.headline)
                .foregroundColor(.black)

            // image picker with arrows
            HStack {
                // left arrow
                Button(action: {
                    withAnimation {
                        selectedIndex = (selectedIndex - 1 + clothingImages.count) % clothingImages.count
                    }
                }) {
                    Image("arrow-icon")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .rotationEffect(.degrees(180)) // make it point left
                }

                Spacer()

                // show the image
                Image(clothingImages[selectedIndex])
                    .resizable()
                    .scaledToFit()
                    .frame(height: 120)

                Spacer()

                // right arrow
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

            // title input field
            VStack(alignment: .leading, spacing: 4) {
                Text("Title:")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)

                TextField("Summarise your opinion into a topic", text: $title)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
                    .shadow(color: .black.opacity(0.1), radius: 6, x: 0, y: 3)
                    .foregroundColor(.black)
            }
            .padding(.horizontal)

            // description input field
            VStack(alignment: .leading, spacing: 4) {
                Text("Description")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)

                TextEditor(text: $description)
                    .frame(height: 100)
                    .padding(4)
                    .background(Color.white)
                    .cornerRadius(8)
                    .shadow(color: .black.opacity(0.1), radius: 6, x: 0, y: 3)
                    .foregroundColor(.black)
                    .environment(\.colorScheme, .light) // make sure it's in light mode
                    .overlay(
                        Group {
                            if description.isEmpty {
                                Text("Elaborate on the context of your opinion")
                                    .foregroundColor(.gray)
                                    .padding(8)
                                    .allowsHitTesting(false) // make sure this doesn’t block typing
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
