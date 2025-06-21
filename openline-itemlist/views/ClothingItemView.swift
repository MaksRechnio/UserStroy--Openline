import SwiftUI

struct ClothingItemView: View {
    let item: ClothingItem
    let isExpanded: Bool
    let onToggleExpand: () -> Void
    let onEdit: (ClothingItem) -> Void
    let onDelete: () -> Void
    var swing: Bool
    
    @State private var angle: Double = 0
    @State private var decay: Double = 1.0

    var body: some View {
        VStack {
            ZStack {
                
                Image(item.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(height: isExpanded ? 240 : 340)
                        .rotationEffect(.degrees(swing ? 2 : 0))
                        .animation(.easeInOut(duration: 0.4), value: swing)
                        .offset(x: swing ? -50 : 0, y: isExpanded ? -40 : -60)
                    
                if !isExpanded {
                    Image("clothing-tag-openline")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60)
                        .offset(x: swing ? -100 : -5, y: 110)
                        .rotationEffect(.degrees(swing ? -5 : 0))
                        .animation(.easeInOut(duration: 0.4), value: swing)
                }
                
            }
            .onTapGesture {
                withAnimation(.easeInOut) {
                    onToggleExpand()
                }
            }
            if isExpanded {
                ClothingItemDetailView(item: item, onClose: onToggleExpand, onEdit: onEdit, onDelete: onDelete, onComment: {})
            }
        }
    }
}
