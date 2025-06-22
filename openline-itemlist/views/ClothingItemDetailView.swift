import SwiftUI

// this is the view that shows a full detail page for a clothing item
struct ClothingItemDetailView: View {
    let item: ClothingItem // the actual clothing item data I pass in
    var onClose: () -> Void // what happens when I tap the X
    var onEdit: (ClothingItem) -> Void // used if I edit the item
    var onDelete: () -> Void // if I wanna delete the item
    var onComment: () -> Void // if I tap "Comment"

    @Namespace private var animation // used for animations if I ever need one
    @State private var showEditSheet = false // keeps track of whether edit screen is open

    var body: some View {
        VStack(spacing: 12) {
            Spacer(minLength: 20) // gives it breathing room from the top

            // the title block with quotes and gold colour
            VStack(spacing: 4) {
                Text("\"\(item.title)\"")
                    .font(.headline)
                    .foregroundColor(Color(hex: "#D0A249")) // I’m using a custom hex color
                    .multilineTextAlignment(.center)
            }
            .padding(.horizontal)

            // author line right below the title
            Text("Author: \(item.author)")
                .font(.footnote)
                .foregroundColor(.gray)

            // Edit / Close (X) / Comment buttons in a row
            HStack(spacing: 20) {
                Button(action: {
                    // I added a little haptic tap so it feels nice
                    let impact = UIImpactFeedbackGenerator(style: .medium)
                    impact.impactOccurred()
                    showEditSheet = true
                }) {
                    Text("EDIT")
                        .font(.caption)
                        .foregroundColor(.white)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 6)
                        .background(Color.orange)
                        .cornerRadius(6)
                }
                // when the sheet shows up, I pass the item and handlers
                .sheet(isPresented: $showEditSheet) {
                    EditItemView(
                        item: item,
                        onEdit: { item in
                            showEditSheet = false // close the sheet
                            onEdit(item) // update the item
                        },
                        onDelete: onDelete // just forward the delete handler
                    )
                }

                // this is the X button to close the view
                Button(action: onClose) {
                    Image(systemName: "xmark")
                        .foregroundColor(.black)
                        .padding(10)
                        .background(Color.white)
                        .clipShape(Circle())
                        .shadow(radius: 1)
                }

                // comment button just triggers the passed handler
                Button(action: onComment) {
                    Text("Comment")
                        .font(.caption)
                        .foregroundColor(.white)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 6)
                        .background(Color.teal)
                        .cornerRadius(6)
                }
            }
            .padding(.top, 8)

            // Description section with title and the actual description
            VStack(spacing: 6) {
                Text("Description")
                    .font(.headline)
                    .padding(.bottom, 4)
                    .foregroundColor(Color(.black))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 50) // keeping it symmetrical

                Text(item.description)
                    .font(.body)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.leading) // aligns left and wraps
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .fixedSize(horizontal: false, vertical: true) // lets it grow down naturally
                    .padding(.horizontal, 50)
            }

            Spacer() // pushes everything to top
        }
        .transition(.move(edge: .bottom).combined(with: .opacity)) // smooth slide-in animation
    }
}

// this is a helper I added so I can use hex strings like "#D0A249"
extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#")

        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)

        let r = Double((rgb >> 16) & 0xFF) / 255
        let g = Double((rgb >> 8) & 0xFF) / 255
        let b = Double(rgb & 0xFF) / 255

        self.init(red: r, green: g, blue: b)
    }
}
