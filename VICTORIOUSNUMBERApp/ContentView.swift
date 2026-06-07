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
                ErrorView(error: error) {
                    Task { await viewModel.loadData() }
                }
            } else {
                CodeNameListView(
                    codeNames: viewModel.codeNames,
                    isLoading: viewModel.isLoading,
                    onGenerate: { viewModel.generateCodeNames() }
                )
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
