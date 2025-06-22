import SwiftUI

// This is the custom shape for the curved clothesline
struct ClotheslineCurve: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        // start drawing from the left-middle
        path.move(to: CGPoint(x: rect.minX, y: rect.midY))

        // draw a curve to the right-middle
        // control points are used to make it a nice curve
        path.addCurve(
            to: CGPoint(x: rect.maxX, y: rect.midY),
            control1: CGPoint(x: rect.width * 0.3, y: rect.midY + 60), // pulls it down a bit
            control2: CGPoint(x: rect.width * 0.7, y: rect.midY + 60)  // same here to keep it even
        )

        return path // returns the final path shape
    }
}
