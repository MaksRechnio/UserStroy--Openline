import SwiftUI

struct SwipeCard: View {
    let todo: TodoItem
    var onRemove: () -> Void
    var onTap: () -> Void

    @State private var offset = CGSize.zero

    var body: some View {
        VStack(spacing: 15) {
            // 🧥 Enlarged image area
            Group {
                switch todo.imageSource {
                case .system(let name):
                    Image(systemName: name)
                        .resizable()
                case .asset(let name):
                    Image(name)
                        .resizable()
                }
            }
            .scaledToFit()
            .frame(height: 300) // ⬅️ Bigger image
            .padding(.top)

            // 📝 Title
            Text(todo.title)
                .font(.custom("Poppins-Regular", size: 24))
                .foregroundColor(.black)
                .padding(.horizontal)
                .padding(.bottom)
        }
        .frame(width: 300, height: 450) // ⬅️ Fixed card size
        .background(Color.white)
        .cornerRadius(16)
        .shadow(radius: 5)
        .offset(offset)
        .rotationEffect(.degrees(Double(offset.width / 40)))
        .gesture(
            DragGesture()
                .onChanged { gesture in offset = gesture.translation }
                .onEnded { _ in
                    if abs(offset.width) > 100 {
                        onRemove()
                    } else {
                        offset = .zero
                    }
                }
        )
        .onTapGesture {
            onTap()
        }
    }
}
