import SwiftUI

struct ErrorView: View {
    let error: String
    let onRetry: () -> Void

    var body: some View {
        VStack {
            Image(systemName: "exclamationmark.triangle")
                .accessibilityHidden(true)
                .font(.largeTitle)
                .foregroundStyle(.yellow)
            Text(error)
                .multilineTextAlignment(.center)
                .padding()
            Button("Réessayer", action: onRetry)
                .buttonStyle(.borderedProminent)
        }
    }
}
