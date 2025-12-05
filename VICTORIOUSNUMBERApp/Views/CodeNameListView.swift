//
//  ListView.swift
//  VICTORIOUSNUMBER
//
//  Created by Mo on 28/01/2022.
//

import SwiftUI
import UIKit

struct CodeNameListView: View {
    @State private var viewModel = CodeNameViewModel()

    var body: some View {
        ZStack {
            if viewModel.isLoading {
                ProgressView("Chargement...")
            } else if let error = viewModel.errorMessage {
                VStack(spacing: 16) {
                    Image(systemName: "exclamationmark.triangle")
                        .font(.largeTitle)
                        .foregroundColor(.yellow)
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
                    Text("CODENAME")
                        .font(.largeTitle)

                    List(viewModel.codeNames, id: \.self) { codename in
                        Text(codename)
                            .font(.title2)
                            .foregroundColor(.red)
                    }
                    .textSelection(.enabled) // Allows native selection/copy without UIKit

                    Button(action: {
                        withAnimation {
                            viewModel.generateCodeNames()
                        }
                    }, label: {
                        Text("Générer")
                    })
                    .font(.title3)
                    .fontWeight(.semibold)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 10)
                    .background(.thinMaterial)
                    .cornerRadius(5)
                    .disabled(viewModel.isLoading)

                    Spacer()
                }
                .overlay(Group {
                    if viewModel.codeNames.isEmpty {
                        Text("Appuyez sur Générer")
                            .foregroundColor(.secondary)
                    }
                })
            }
        }
        .onAppear {
             if viewModel.codeNames.isEmpty && !viewModel.isLoading {
                 viewModel.generateCodeNames()
             }
        }
        .onChange(of: viewModel.isLoading) {
            if !viewModel.isLoading && viewModel.codeNames.isEmpty && viewModel.errorMessage == nil {
                viewModel.generateCodeNames()
            }
        }
    }
}

#Preview {
    NavigationStack {
        CodeNameListView()
            .preferredColorScheme(.dark)
    }
}
