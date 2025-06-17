import SwiftUI

struct ClothingItem: Identifiable {
    let id = UUID()
    let imageName: String
    let title: String
    let author: String
}

struct ClotheslineView: View {
    let items: [ClothingItem]
    let onAdd: (TodoItem) -> Void // 👈 this stays

    @State private var selectedIndex = 0
    @State private var showingNewItemSheet = false

    var body: some View {
        GeometryReader { geo in
            ZStack {
                Color.white.ignoresSafeArea()

                VStack(spacing: 0) {
                    Image("openline-logo")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 60)
                        .padding(.top)

                    Spacer().frame(height: 20)

                    VStack(spacing: 4) {
                        Text("“\(items[selectedIndex].title)”")
                            .font(.headline)
                            .multilineTextAlignment(.center)
                            .transition(.opacity)
                        Text("Author: \(items[selectedIndex].author)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .transition(.opacity)
                    }
                    .animation(.easeInOut, value: selectedIndex)
                    .padding(.horizontal)

                    Spacer().frame(height: 30)

                    ClotheslineCurve()
                        .stroke(Color.orange.opacity(0.7), lineWidth: 2)
                        .frame(height: 100)
                        .padding(.horizontal, 16)

                    TabView(selection: $selectedIndex) {
                        ForEach(Array(items.enumerated()), id: \.offset) { index, item in
                            ClothingItemView(imageName: item.imageName, swing: selectedIndex != index)
                                .frame(width: geo.size.width, height: geo.size.height * 0.4)
                                .tag(index)
                        }
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    .animation(.easeInOut, value: selectedIndex)

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
                            .background(Color(red: 42/255, green: 139/255, blue: 186/255))
                            .clipShape(Circle())
                            .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 2)
                    }
                    .padding(.bottom, 32)
                    .sheet(isPresented: $showingNewItemSheet) {
                        // ✅ Only pass `onAdd`. No `dismiss:` allowed.
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
