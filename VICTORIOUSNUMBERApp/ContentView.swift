//
//  ListView.swift
//  VICTORIOUSNUMBER
//
//  Created by Mo on 28/01/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var viewModel = CodeNameViewModel()

    var body: some View {
        ZStack {
            if viewModel.isLoading {
                ProgressView("Chargement...")
            } else if let error = viewModel.errorMessage {
                VStack {
                    Image(systemName: "exclamationmark.triangle")
                        .accessibilityHidden(true)
                        .font(.largeTitle)
                        .foregroundStyle(.yellow)
                    Text(error)
                        .multilineTextAlignment(.center)
                        .padding()
                    Button("Réessayer") {
                        Task { await viewModel.loadData() }
                    }
                    .buttonStyle(.borderedProminent)
                }
            } else {
                VStack {
                    Text("VICTORIOUSNUMBER")
                        .font(.largeTitle)
						.fontWeight(.light)
						.fontDesign(.rounded)
						.foregroundStyle(.blue)
						.multilineTextAlignment(.center)
						
                    List(viewModel.codeNames, id: \.self) { codename in
                        Text(codename)
                            .font(.title2)
							.fontWeight(.light)
                            .foregroundStyle(.red)
                    }
                    .textSelection(.enabled)

                    Button("Générer") {
                        withAnimation {
                            viewModel.generateCodeNames()
                        }
                    }
                    .font(.title3)
					.fontWeight(.light)
                    .padding()
                    .background(.thinMaterial)
                    .clipShape(.rect(cornerRadius: 10))
                    .disabled(viewModel.isLoading)

                    Spacer()
                }
                .overlay(Group {
                    if viewModel.codeNames.isEmpty {
                        Text("Appuyez sur Générer")
                            .foregroundStyle(.secondary)
                    }
                })
            }
        }
        .task {
            await viewModel.loadData()
        }
    }
}

#Preview {
	ContentView()
		.preferredColorScheme(.dark)

}
