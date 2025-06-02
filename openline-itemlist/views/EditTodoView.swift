import SwiftUI

struct EditTodoView: View {
    @State var todo: TodoItem
    var onSave: (TodoItem) -> Void
    var onDelete: () -> Void
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationView {
            Form {
                TextField("Title", text: $todo.title)

                Picker("Image Type", selection: Binding(
                    get: {
                        switch todo.imageSource {
                        case .system: return "System"
                        case .asset: return "Asset"
                        }
                    },
                    set: { type in
                        switch type {
                        case "System": todo.imageSource = .system("star")
                        case "Boxers": todo.imageSource = .asset("openline-boxers-blue")
                        case "Coat": todo.imageSource = .asset("openline-coat-red")
                        case "Hoodie": todo.imageSource = .asset("openline-hoodie-purple")
                        case "T-shirt": todo.imageSource = .asset("openline-tshirt-yellow")
                        case "Sundress": todo.imageSource = .asset("openline-sundress-beige")
                        
                        default: break
                        }
                    })
                ) {
                    Text("System Symbol").tag("System")
                    Text("Local Asset").tag("Asset")
                }

                switch todo.imageSource {
                case .system(let name):
                    TextField("SF Symbol", text: Binding(
                        get: { name },
                        set: { todo.imageSource = .system($0) }
                    ))
                case .asset(let name):
                    TextField("Asset Name", text: Binding(
                        get: { name },
                        set: { todo.imageSource = .asset($0) }
                    ))
                }

                Section {
                    Button(action: {
                        onDelete()
                        dismiss()
                    }) {
                        Text("Delete")
                            .foregroundColor(.white)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 20)
                            .frame(maxWidth: .infinity)
                            .background(Color(red: 193 / 255, green: 88 / 255, blue: 79 / 255)) // #C1584F
                            .clipShape(Capsule())
                            .multilineTextAlignment(.center)
                    }
                    .listRowBackground(Color.clear) // optional: remove default background
                    .frame(maxWidth: .infinity, alignment: .center)
                }
            }
            .navigationTitle("Edit Task")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        onSave(todo)
                        dismiss()
                    }
                }
            }
        }
    }
}
