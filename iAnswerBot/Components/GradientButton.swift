import SwiftUI

struct GradientButton: View {

    var buttonTitle: String
    var buttonAction: () -> Void
    @State private var angle: Double = 0

    var body: some View {
        Button(action: buttonAction) {
            GeometryReader { geo in
                ZStack {
                    AngularGradient(colors: CustomColorArray.gradient1, center: .center, angle: .degrees(angle))
                        .blendMode(.overlay)
                        .blur(radius: 8)
                        .mask(
                            RoundedRectangle(cornerRadius: 16)
                                .frame(height: 50)
                                .frame(maxWidth: geo.size.width - 16)
                                .blur(radius: 8)
                        )
                        .onAppear {
                            withAnimation(.linear(duration: 7)) {
                                angle += 350
                            }
                        }
                    GradientText(text: buttonTitle)
                        .font(.headline)
                        .frame(width: geo.size.width - 16, height: 50)
                        .background(Color("tertiaryBackground").opacity(0.9))
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(.white, lineWidth: 2)
                                .blendMode(.normal)
                                .opacity(0.7)
                        )
                        .cornerRadius(16)
                }
            }
            .frame(height: 50)
        }
    }
}

