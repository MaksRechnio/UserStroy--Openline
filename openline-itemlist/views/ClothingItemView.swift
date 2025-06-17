import SwiftUI

struct ClothingItemView: View {
    let imageName: String
    var swing: Bool

    var body: some View {
        VStack {
            ZStack {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 240)
                    .rotationEffect(.degrees(swing ? 2 : 0))
                    .animation(.easeInOut(duration: 0.4), value: swing)

                Image("clothing-tag-openline")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60)
                    .offset(x: swing ? -10 : -5, y: 120)
                    .rotationEffect(.degrees(swing ? -5 : 0))
                    .animation(.easeInOut(duration: 0.4), value: swing)
            }
        }
    }
}
