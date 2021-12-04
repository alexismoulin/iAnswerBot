import SwiftUI
import CTScanText

struct ContentView: View {

    let model = BERT()
    @State private var answerLabel: String = ""
    @State private var context: String = ""
    @State private var question: String = ""

    var body: some View {
        VStack {
            Form {
                Section {
                    ScanTextEditor("Scan your text", text: $context)
                        .frame(height: 200)
                } header: {
                    Text("Text Editor in form")
                }
                TextField("Enter question", text: $question)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button("Answer") {
                    DispatchQueue.global(qos: .userInitiated).async {
                        let answer = self.model.findAnswer(for: self.question, in: self.context)
                        self.answerLabel = String(answer)
                    }

                }.padding()
                    .foregroundColor(Color.white)
                    .background(Color.green)
                    .cornerRadius(10)

                 Text(answerLabel)
                    .font(.title)
            }
        }
    }
}
