import SwiftUI

struct GradientTextfield: View {

    @Binding var editingTextfield: Bool
    @Binding var textfieldString: String
    @Binding var iconBounce: Bool
    var textfieldPlaceholder: String
    var textfieldIconString: String
    var height: CGFloat?
    private let generator = UISelectionFeedbackGenerator()
    
    func animationPrompt(isEditing: Bool) {
        editingTextfield = isEditing
        generator.selectionChanged()
        if isEditing {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.4, blendDuration: 0.5)) {
                iconBounce.toggle()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                withAnimation(.spring(response: 0.3, dampingFraction: 0.4, blendDuration: 0.5)) {
                    iconBounce.toggle()
                }
            }
        }
    }

    var body: some View {
        HStack(spacing: 12) {
            TextfieldIcon(iconName: textfieldIconString, currentlyEditing: $editingTextfield, passedImage: .constant(nil))
                .scaleEffect(iconBounce ? 1.2 : 1)
            TextField(textfieldPlaceholder, text: $textfieldString) { isEditing in
                animationPrompt(isEditing: isEditing)
//                editingTextfield = isEditing
//                generator.selectionChanged()
//                if isEditing {
//                    withAnimation(.spring(response: 0.3, dampingFraction: 0.4, blendDuration: 0.5)) {
//                        iconBounce.toggle()
//                    }
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
//                        withAnimation(.spring(response: 0.3, dampingFraction: 0.4, blendDuration: 0.5)) {
//                            iconBounce.toggle()
//                        }
//                    }
//                }
            }
            .colorScheme(.dark)
            .foregroundColor(.white.opacity(0.7))
        }
        .frame(height: height)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(.white, lineWidth: 1)
                .blendMode(.overlay)
        )
        .background(
            Color.textfield
                .cornerRadius(16)
        )
    }
}

struct GradientTextfield_Previews: PreviewProvider {
    static var previews: some View {
        GradientTextfield(editingTextfield: .constant(true), textfieldString: .constant("some text here"), iconBounce: .constant(false), textfieldPlaceholder: "Test textfield", textfieldIconString: "textformat.alt")
    }
}
