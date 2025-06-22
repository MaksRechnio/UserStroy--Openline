import SwiftUI

struct NewItemView: View {
    @Environment(\.dismiss) var dismiss // lets me close the view when needed
    var onAdd: (ClothingItem) -> Void // function that runs when I add the new item

    @State private var selectedIndex = 0 // keeps track of which clothing image is selected
    @State private var title = "" // text for the title input
    @State private var description = "" // text for the description input

    // list of clothing image names that I can scroll through
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
            // header with a cancel (X) button and a save button
            HStack {
                // cancel button just closes the sheet
                Button(action: { dismiss() }) {
                    Image("x-icon")
                        .resizable()
                        .frame(width: 16, height: 16)
                        .padding()
                }

                Spacer()

                // save button creates a new item and runs onAdd
                Button(action: {
                    let newItem = ClothingItem(
                        imageName: clothingImages[selectedIndex],
                        title: title,
                        description: description,
                        author: "" // I’m not entering author here so it's left empty
                    )
                    onAdd(newItem) // I pass it to the function from the parent
                    dismiss() // then close the view
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
                .disabled(title.isEmpty || description.isEmpty) // disables the button if inputs are empty
                .opacity(title.isEmpty || description.isEmpty ? 0.4 : 1.0) // fade effect if disabled
                .padding()
            }

            // title for the clothing selector
            Text("Clothing type:")
                .font(.headline)
                .foregroundColor(.black)

            // image selector with left/right arrows
            HStack {
                // left arrow moves backwards
                Button(action: {
                    withAnimation {
                        selectedIndex = (selectedIndex - 1 + clothingImages.count) % clothingImages.count
                    }
                }) {
                    Image("arrow-icon")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .rotationEffect(.degrees(180)) // flips the arrow to face left
                }

                Spacer()

                // show the selected clothing image
                Image(clothingImages[selectedIndex])
                    .resizable()
                    .scaledToFit()
                    .frame(height: 120)

                Spacer()

                // right arrow moves forward
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
                Text("Title:") // heading above the input
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)

                // the input itself with placeholder in grey
                TextField("", text: $title, prompt: Text("Summarise your opinion into a topic").foregroundColor(Color(hex: "#A9A9A9")))
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
                    .shadow(color: .black.opacity(0.1), radius: 6, x: 0, y: 3)
                    .foregroundColor(.black)
            }
            .padding(.horizontal)

            // description input field
            VStack(alignment: .leading, spacing: 4) {
                Text("Description") // heading above the input
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)

                ZStack(alignment: .topLeading) {
                    // text editor for entering the description
                    TextEditor(text: $description)
                        .frame(height: 100)
                        .padding(8)
                        .background(Color.white)
                        .cornerRadius(8)
                        .shadow(color: .black.opacity(0.1), radius: 6, x: 0, y: 3)
                        .foregroundColor(.black)
                        .environment(\.colorScheme, .light)

                    // placeholder text if empty
                    if description.isEmpty {
                        Text("Elaborate on the context of your opinion")
                            .foregroundColor(Color(hex: "#A9A9A9"))
                            .padding(12)
                            .allowsHitTesting(false)
                    }
                }
            }
            .padding(.horizontal)

            Spacer() // pushes everything up
        }
        .padding(.top)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
                .shadow(radius: 8) // gives the whole card a soft shadow
        )
    }
}
