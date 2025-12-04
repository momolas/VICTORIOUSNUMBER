//
//  ListView.swift
//  VICTORIOUSNUMBER
//
//  Created by Mo on 28/01/2022.
//

import SwiftUI
import UIKit

struct CodeNameListView: View {
    @StateObject private var viewModel = CodeNameViewModel()

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
                List {
                    ForEach(viewModel.codeNames, id: \.self) { codename in
                        HStack {
                            Image(systemName: "number.circle.fill") // Decorative icon
                                .foregroundColor(.accentColor)
                            Text(codename.capitalized) // Cleaner look than uppercased
                                .font(.headline)
                                .foregroundColor(.primary)
                            Spacer()
                            Image(systemName: "doc.on.doc")
                                .font(.caption)
                                .foregroundColor(.secondary)
                                .onTapGesture {
                                    UIPasteboard.general.string = codename
                                    // Could add a toast here ideally
                                }
                        }
                        .padding(.vertical, 4)
                    }
                }
                .listStyle(.insetGrouped) // Modern list style
                .refreshable {
                    viewModel.generateCodeNames()
                }
                .overlay(Group {
                    if viewModel.codeNames.isEmpty {
                        ContentUnavailableView("Aucun nom généré", systemImage: "text.bubble", description: Text("Appuyez sur Générer pour commencer"))
                    }
                })
            }
        }
        .navigationTitle("Noms de Code")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button(action: {
                    withAnimation {
                        viewModel.generateCodeNames()
                    }
                }) {
                    Label("Générer", systemImage: "arrow.clockwise")
                }
                .disabled(viewModel.isLoading)
            }
        }
        .task {
            // Use task to wait for loading if needed, or trigger generation when data is ready
            if viewModel.codeNames.isEmpty && !viewModel.isLoading {
                 viewModel.generateCodeNames()
            }
        }
        .onChange(of: viewModel.isLoading) { isLoading in
            if !isLoading && viewModel.codeNames.isEmpty && viewModel.errorMessage == nil {
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
