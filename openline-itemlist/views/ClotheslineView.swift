// back to the stable version before trying the curved scroll nonsense
import SwiftUI

struct ClotheslineView: View {
    let items: [ClothingItem] // the list of clothes I wanna scroll
    let onAdd: (ClothingItem) -> Void // callback when I add a new one
    let onEdit: (ClothingItem, Int) -> Void // callback when I edit an item
    let onDelete: (Int) -> Void // callback when I delete an item
    
    @State private var selectedIndex = 0 // tracks which item is shown
    @State private var showingNewItemSheet = false // toggles the new item modal
    @State private var isExpanded = false // for showing more details or not

    var body: some View {
        GeometryReader { geo in
            ZStack {
                Color.white.ignoresSafeArea() // plain white background

                VStack(spacing: 0) {
                    Image("openline-logo") // app logo at top
                        .resizable()
                        .scaledToFit()
                        .frame(height: 60)
                        .padding(.top)

                    if !isExpanded {
                        Spacer().frame(height: 20) // gap below logo
                        
                        VStack(spacing: 4) {
                            Text("“\(items[selectedIndex].title)”") // clothing title
                                .font(.headline)
                                .multilineTextAlignment(.center)
                                .foregroundColor(.black)
                                .transition(.opacity)
                            Text("Author: \(items[selectedIndex].author)") // author name
                                .font(.subheadline)
                                .foregroundColor(.gray)
                                .transition(.opacity)
                        }
                        .animation(.easeInOut, value: selectedIndex)
                        .padding(.horizontal)
                    }

                    ZStack {
                        ClotheslineCurve() // curved line behind the clothes
                            .stroke(Color.black, lineWidth: 2)
                            .frame(height: 90)
                            .padding(.horizontal, 16)
                            .offset(y: -200) // pushes it up behind the item
                        
                        // just a normal swipeable tab view for now
                        TabView(selection: $selectedIndex) {
                            ForEach(Array(items.enumerated()), id: \.offset) { index, item in
                                ClothingItemView(
                                    item: item,
                                    isExpanded: isExpanded,
                                    onToggleExpand: { isExpanded.toggle() }, // toggles expanded card view
                                    onEdit: { item in onEdit(item, index) }, // passes item + index to edit
                                    onDelete: { onDelete(index) }, // deletes by index
                                    swing: selectedIndex != index // controls animation
                                )
                                .frame(width: geo.size.width, height: geo.size.height * 0.4)
                                .tag(index) // links tab view to selectedIndex
                            }
                        }
                        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never)) // no dots
                        .animation(.easeInOut, value: selectedIndex)
                    }
                    
                    Spacer()

                    Button(action: {
                        showingNewItemSheet = true
                    }) {
                        Image(systemName: "plus")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .foregroundColor(.white)
                            .frame(width: 60, height: 60)
                            .background(Color(red: 42/255, green: 139/255, blue: 186/255)) // blue bg
                            .clipShape(Circle())
                            .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 2)
                    }
                    .padding(.bottom, 32)
                    .sheet(isPresented: $showingNewItemSheet) {
                        NewItemView(onAdd: { item in
                            onAdd(item) // sends new item to parent
                            showingNewItemSheet = false // closes the modal
                        })
                    }
                }
            }
        }
    }
}
