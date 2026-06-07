import SwiftUI

struct CodeNameListView: View {
    let codeNames: [String]
    let isLoading: Bool
    let onGenerate: () -> Void

    var body: some View {
        VStack {
            Text("VICTORIOUSNUMBER")
                .font(.largeTitle)
                .fontWeight(.light)
                .fontDesign(.rounded)
                .foregroundStyle(.blue)
                .multilineTextAlignment(.center)
                
            List(codeNames, id: \.self) { codename in
                Text(codename)
                    .font(.title2)
                    .fontWeight(.light)
                    .foregroundStyle(.red)
            }
            .textSelection(.enabled)

            Button("Générer") {
                withAnimation {
                    onGenerate()
                }
            }
            .font(.title3)
            .fontWeight(.light)
            .padding()
            .background(.thinMaterial)
            .clipShape(.rect(cornerRadius: 10))
            .disabled(isLoading)

            Spacer()
        }
        .overlay(Group {
            if codeNames.isEmpty {
                Text("Appuyez sur Générer")
                    .foregroundStyle(.secondary)
            }
        })
    }
}
