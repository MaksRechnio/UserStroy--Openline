import SwiftUI

struct NewItemView: View {
    @Environment(\.dismiss) var dismiss
    var onAdd: (ClothingItem) -> Void

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

    var body: some View {
        VStack(spacing: 16) {
            // Header with cancel and save buttons
            HStack {
                Button(action: { dismiss() }) {
                    Image("x-icon")
                        .resizable()
                        .frame(width: 16, height: 16)
                        .padding()
                }

                Spacer()

                Button(action: {
                    let newItem = ClothingItem(
                        imageName: clothingImages[selectedIndex],
                        title: title,
                        description: description,
                        author: ""
                    )
                    onAdd(newItem)
                    dismiss()
                }) {
                    Text("SAVE")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(Color(.yellow))
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
                Text("Title:") // heading text
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.black) // make the heading black

                TextField("", text: $title, prompt: Text("Summarise your opinion into a topic").foregroundColor(Color(hex: "#A9A9A9")))
                    .padding()
                    .background(Color.white) // white box background
                    .cornerRadius(8)
                    .shadow(color: .black.opacity(0.1), radius: 6, x: 0, y: 3) // soft shadow
                    .foregroundColor(.black) // text typed in is black
            }
            .padding(.horizontal)

            VStack(alignment: .leading, spacing: 4) {
                Text("Description")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.black) // heading in black

                ZStack(alignment: .topLeading) {
                    TextEditor(text: $description)
                        .frame(height: 100)
                        .padding(8)
                        .background(Color.white) // white box background
                        .cornerRadius(8)
                        .shadow(color: .black.opacity(0.1), radius: 6, x: 0, y: 3) // soft shadow
                        .foregroundColor(.black) // text typed in is black
                        .environment(\.colorScheme, .light)

                    if description.isEmpty {
                        Text("Elaborate on the context of your opinion")
                            .foregroundColor(Color(hex: "#A9A9A9"))
                            .padding(12)
                            .allowsHitTesting(false)
                    }
                }
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
