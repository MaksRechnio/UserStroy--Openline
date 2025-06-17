import SwiftUI

struct TodoSwipeView: View {
    @State private var todos: [TodoItem] = [
        TodoItem(title: "King's Day Parties", description: "We will have a big party on the streets of eindhoven and you can see and find beer pretty much everwhere", imageSource: .asset("openline-tshirt-yellow")),
        TodoItem(title: "Constitution Day Marches", description: "In order to properly celebrate our constitution day we will have a march", imageSource: .asset("openline-coat-red")),
        TodoItem(title: "International Woman's Day", description: "More information about the international woman's day and it's origins", imageSource: .asset("openline-sundress-beige")),
        TodoItem(title: "Sexual Absuse", description: "More information about the sexual absue and it's countermesasures in today's world and dutch society", imageSource: .asset("openline-boxers-blue"))
    ]
    
    
    @State private var showingNewItemSheet = false
    @GestureState private var isPressed = false
    @State private var itemForDetail: TodoItem?
    @State private var itemForEdit: TodoItem?
    
    
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea() // ⬅️ this sets the full background to white
            
            VStack {
                Image("openlinelogo")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 80) // adjust height as needed
                                .padding(.top, 20)
                ZStack {
                    ForEach(todos.reversed()) { todo in
                        SwipeCard(todo: todo, onRemove: {
                            if let index = todos.firstIndex(of: todo) {
                                let swiped = todos.remove(at: index)
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                    todos.append(swiped)
                                }
                            }
                        }, onTap: {
                            itemForDetail = todo
                        })
                        .padding()
                    }
                }
                
                Button(action: {
                    showingNewItemSheet = true
                }) {
                    Image(systemName: "plus")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                        .foregroundColor(.white)
                        .frame(width: 60, height: 60)
                        .background(Color(red: 42/255, green: 139/255, blue: 186/255))
                        .clipShape(Circle())
                        .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 2)
                        .scaleEffect(isPressed ? 0.9 : 1.0)
                        .animation(.spring(response: 0.3, dampingFraction: 0.5), value: isPressed)
                }
                .simultaneousGesture(
                    DragGesture(minimumDistance: 0)
                        .updating($isPressed) { _, isPressed, _ in
                            isPressed = true
                        }
                )
            }
        }
        .sheet(isPresented: $showingNewItemSheet) {
            NewItemView(onAdd: { newItem in
                todos.append(newItem)
                showingNewItemSheet = false
            })
        }
        .sheet(item: $itemForDetail) { todo in
            ItemDetailView(todo: todo, onEdit: {
                itemForEdit = todo
                itemForDetail = nil
            })
        }
        .sheet(item: $itemForEdit) { todo in
            EditTodoForm(todo: todo, onSave: { updated in
                if let index = todos.firstIndex(of: todo) {
                    todos[index] = updated
                }
                itemForEdit = nil
            })
        }
    }
}
