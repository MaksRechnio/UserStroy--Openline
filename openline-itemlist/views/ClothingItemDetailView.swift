import SwiftUI

struct ClothingItemDetailView: View {
    let item: ClothingItem
    var onClose: () -> Void
    var onEdit: (ClothingItem) -> Void
    var onDelete: () -> Void
    var onComment: () -> Void

    @Namespace private var animation
    @State private var showEditSheet = false

    var body: some View {
        VStack(spacing: 12) {
            Spacer(minLength: 20)

            // Title & Subtitle (stacked)
            VStack(spacing: 4) {
                Text("\"\(item.title)\"")
                    .font(.headline)
                    .foregroundColor(Color(hex: "#D0A249"))
                    .multilineTextAlignment(.center)
            }
            .padding(.horizontal)

            // Author
            Text("Author: \(item.author)")
                .font(.footnote)
                .foregroundColor(.gray)

            // Edit / X / Comment buttons
            HStack(spacing: 20) {
                Button(action: {showEditSheet = true}) {
                    Text("EDIT")
                        .font(.caption)
                        .foregroundColor(.white)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 6)
                        .background(Color.orange)
                        .cornerRadius(6)
                }
                .sheet(isPresented: $showEditSheet) {
                    EditItemView(
                        item: item,
                        onEdit: { item in
                            showEditSheet = false
                            onEdit(item)
                        },
                        onDelete: onDelete,
                    )
                }

                Button(action: onClose) {
                    Image(systemName: "xmark")
                        .foregroundColor(.black)
                        .padding(10)
                        .background(Color.white)
                        .clipShape(Circle())
                        .shadow(radius: 1)
                }

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

            // Description Block
            VStack(spacing: 6) {
                Text("Description")
                    .font(.headline)
                    .padding(.bottom, 4)
                    .foregroundColor(Color(.black))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 50)

                Text(item.description)
                    .font(.body)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.leading) // I make sure it aligns nicely on the left
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .fixedSize(horizontal: false, vertical: true) // This is key: allows wrapping to height
                    .padding(.horizontal, 50)
            } 
            Spacer()
        }
        .transition(.move(edge: .bottom).combined(with: .opacity))
    }
}

// Color from HEX helper
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
