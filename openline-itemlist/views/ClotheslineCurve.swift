import SwiftUI

struct ClotheslineCurve: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let midY = rect.midY
        path.move(to: CGPoint(x: rect.minX, y: midY))
        path.addQuadCurve(to: CGPoint(x: rect.maxX, y: midY),
                          control: CGPoint(x: rect.midX, y: midY + 40))
        return path
    }
}
