import SwiftUI
import CTScanText

struct HomeView: View {

    let model = BERT()

    @State private var answerLabel: String = ""
    @State private var context: String = ""
    @State private var question: String = ""
    @State private var editingTextfield: Bool = false
    @State private var iconBounce: Bool = false

    var body: some View {
        ZStack {
            Image("background-2")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)

            VStack {
                VStack(alignment: .leading, spacing: 16) {
                    // Text scanner
                    Text("Text Scanner")
                        .foregroundColor(.white)
                        .font(.title2.bold())
                    ScanTextEditor("Scan your text here", text: $context, backgroundColor: UIColor(.textfield), borderColor: .white, borderWidth: 3, cornerRadius: 16)
                        .frame(height: 300)

                    CustomDivider()

                    // Question textfield
                    Text("Ask your question")
                        .foregroundColor(.white)
                        .font(.title2.bold())

                    GradientTextfield(editingTextfield: $editingTextfield, textfieldString: $question, iconBounce: $iconBounce, textfieldPlaceholder: "Enter question", textfieldIconString: "questionmark")

                    CustomDivider()

                    // Question textfield
                    Text("Get your answer")
                        .foregroundColor(.white)
                        .font(.title2.bold())

                    GradientButton(buttonTitle: "Answer") {
                        DispatchQueue.global(qos: .userInitiated).async {
                            let answer = self.model.findAnswer(for: self.question, in: self.context)
                            self.answerLabel = String(answer)
                            print(context)
                            print(question)
                            print(answer)
                        }
                    }

                    Text(answerLabel)
                        .font(.title)

                }.padding(16)


            }
            .cardStyle()

            VStack {
                Spacer()
                Button {
                    answerLabel = ""
                    context = ""
                    question = ""
                } label: {
                    Image(systemName: "trash")
                        .foregroundColor(.white)
                        .font(.system(size: 15, weight: .medium, design: .rounded))
                        .background(
                            Circle()
                                .stroke(.white.opacity(0.2), lineWidth: 1)
                                .frame(width: 42, height: 42, alignment: .center)
                                .overlay(
                                    VisualEffectBlur(blurStyle: .dark)
                                        .cornerRadius(21)
                                        .frame(width: 42, height: 42, alignment: .center)
                                )
                        )
                }

            }.padding(.bottom, 44)
        }
        .preferredColorScheme(.dark)

    }

}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
