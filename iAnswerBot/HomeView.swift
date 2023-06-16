import SwiftUI

struct HomeView: View {

    @State private var answerLabel: String = ""
    @State private var scanResults: String = ""
    @State private var question: String = ""
    @State private var editingTextfield: Bool = false
    @State private var iconBounce: Bool = false
    @State private var showCameraScannerView: Bool = false

    var body: some View {
        ZStack {
            Image("background-2")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)

            VStack {
                VStack(alignment: .leading, spacing: 16) {
                    // MARK: - Text Scanner Section
                    Text("Text Scanner")
                        .foregroundColor(.white)
                        .font(.title2.bold())

                    GradientTextfield(
                        editingTextfield: $editingTextfield,
                        textfieldString: $scanResults,
                        iconBounce: $iconBounce,
                        textfieldPlaceholder: "Press the scan button",
                        textfieldIconString: "camera",
                        height: 200
                    )
                    
                    GradientButton(buttonTitle: "Scan") { showCameraScannerView.toggle() }

                    CustomDivider()

                    // MARK: - Question Section
                    Text("Ask your question")
                        .foregroundColor(.white)
                        .font(.title2.bold())

                    GradientTextfield(editingTextfield: $editingTextfield, textfieldString: $question, iconBounce: $iconBounce, textfieldPlaceholder: "Enter question", textfieldIconString: "questionmark")

                    CustomDivider()

                    // MARK: - Answer Section
                    Text("Get your answer")
                        .foregroundColor(.white)
                        .font(.title2.bold())

                    GradientButton(buttonTitle: "Answer") { }

                    Text(answerLabel)
                        .font(.title)

                }.padding(16)


            }
            .cardStyle()
            
            // MARK: - DELETE BUTTON
            VStack {
                Spacer()
                Button {
                    answerLabel = ""
                    scanResults = ""
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
        .sheet(isPresented: $showCameraScannerView) {
                   CameraScanner(
                    startScanning: $showCameraScannerView,
                    scanResult: $scanResults
                   )
               }

    }

}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
