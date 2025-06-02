import SwiftUI

struct ItemDetailView: View {
    let todo: TodoItem
    var onEdit: () -> Void
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Group {
                    switch todo.imageSource {
                    case .system(let name):
                        Image(systemName: name)
                            .resizable()
                    case .asset(let name):
                        Image(name)
                            .resizable()
                    }
                }
                .scaledToFit()
                .frame(width: 120, height: 120)
                .padding()

                Text(todo.title)
                    .font(.title)
                    .padding(.top)

                Text(todo.description)
                    .font(.body)
                    .padding([.horizontal, .bottom])

                Spacer()
            }
            .navigationTitle("Item Details")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Edit") {
                        onEdit()
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close", role: .cancel) {
                        dismiss()
                    }
                }
            }
        }
    }
}
