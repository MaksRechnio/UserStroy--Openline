// back to the stable version before trying the curved scroll nonsense
import SwiftUI

struct ClotheslineView: View {
    let items: [ClothingItem] // the list of clothes I wanna scroll
    let onAdd: (ClothingItem) -> Void
    let onEdit: (ClothingItem, Int) -> Void
    let onDelete: (Int) -> Void
    
    @State private var selectedIndex = 0 // tracks which item is shown
    @State private var showingNewItemSheet = false // toggles the new item modal
    @State private var isExpanded = false

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
                            Text("\"\(items[selectedIndex].title)\"") // clothing title
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
                            .offset(y:-200)
                        
                        // just a normal swipeable tab view for now
                        TabView(selection: $selectedIndex) {
                            ForEach(Array(items.enumerated()), id: \ .offset) { index, item in
                                ClothingItemView(item: item, isExpanded: isExpanded, onToggleExpand: { isExpanded.toggle() }, onEdit: {item in onEdit(item, index)}, onDelete: { onDelete(index) }, swing: selectedIndex != index)
                                    .frame(width: geo.size.width, height: geo.size.height * 0.4)
                                    .tag(index)
                            }
                        }
                        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                        .animation(.easeInOut, value: selectedIndex)
                    }
                    
                    Spacer()

                    Button(action: {
                        showingNewItemSheet = true // opens add item modal
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
                    }
                    .padding(.bottom, 32)
                    .sheet(isPresented: $showingNewItemSheet) {
                        NewItemView(onAdd: { item in
                            onAdd(item)
                            showingNewItemSheet = false
                        })
                    }
                }
            }
        }
    }
}

