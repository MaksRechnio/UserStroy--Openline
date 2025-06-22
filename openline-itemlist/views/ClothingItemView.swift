import SwiftUI

// this is the actual card that shows a clothing item (image + details)
struct ClothingItemView: View {
    let item: ClothingItem // this is the data for one clothing piece
    let isExpanded: Bool // true if I’ve tapped it to expand
    let onToggleExpand: () -> Void // used when I tap the card to expand/collapse
    let onEdit: (ClothingItem) -> Void // lets me trigger edit from the expanded view
    let onDelete: () -> Void // same for delete
    var swing: Bool // used to animate a little swing effect

    // this is just for controlling some rotation animation
    @State private var angle: Double = 0
    @State private var decay: Double = 1.0

    var body: some View {
        VStack {
            ZStack {
                // main clothing image
                Image(item.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(height: isExpanded ? 240 : 340) // size changes depending if expanded
                    .rotationEffect(.degrees(swing ? 2 : 0)) // a small rotation if swinging
                    .animation(.easeInOut(duration: 0.4), value: swing)
                    .offset(x: swing ? -50 : 0, y: isExpanded ? -40 : -60) // positioning the image depending on state

                // tag image (only shows when not expanded)
                if !isExpanded {
                    Image("clothing-tag-openline")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60)
                        .offset(x: swing ? -100 : -5, y: 110) // moving the tag around depending on swing
                        .rotationEffect(.degrees(swing ? -5 : 0)) // slight rotation for fun
                        .animation(.easeInOut(duration: 0.4), value: swing)
                }
            }
            .onTapGesture {
                // when I tap the image, give me that nice haptic bump
                let impact = UIImpactFeedbackGenerator(style: .medium)
                impact.impactOccurred()

                // then expand/collapse the view smoothly
                withAnimation(.easeInOut) {
                    onToggleExpand()
                }
            }

            // if the card is expanded, I show all the details underneath
            if isExpanded {
                ClothingItemDetailView(
                    item: item,
                    onClose: onToggleExpand, // closes when I tap X
                    onEdit: onEdit,          // passes edit callback
                    onDelete: onDelete,      // passes delete callback
                    onComment: {}            // not doing anything for comment right now
                )
            }
        }
    }
}
