//
//  ListView.swift
//  VICTORIOUSNUMBER
//
//  Created by Mo on 28/01/2022.
//

import SwiftUI

struct CodeNameListView: View {
    @StateObject private var viewModel = CodeNameViewModel()

    var body: some View {
        VStack {

            Text("CODENAME")
                .font(.largeTitle)

            List(viewModel.codeNames, id: \.self) { codename in
                Text(codename.uppercased())
                    .font(.title2)
                    .foregroundColor(.red)
            }
            .textSelection(.enabled)

            Button(action: {
                viewModel.generateCodeNames()
            }, label: {
                Text("Générer")
            })
            .font(.title3)
            .fontWeight(.semibold)
            .padding(.horizontal, 24)
            .padding(.vertical, 10)
            .background(.thinMaterial)
            .cornerRadius(5)

            Spacer()
        }
        .onAppear {
            // Initial generation
            if viewModel.codeNames.isEmpty {
                viewModel.generateCodeNames()
            }
        }
        // No need for NavigationView here, as it's already in a NavigationStack from LaunchView
    }
}

#Preview {
    CodeNameListView()
        .preferredColorScheme(.dark)
}
