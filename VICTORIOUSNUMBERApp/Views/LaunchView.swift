//
//  ContentView.swift
//  Shared
//
//  Created by Mo on 28/01/2022.
//

import SwiftUI

struct LaunchView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
                Spacer()
                
                VStack(spacing: 10) {
                    Text("VICTORIOUSNUMBER")
                        .font(.system(size: 32, weight: .heavy))
                        .foregroundStyle(.blue)
                        .multilineTextAlignment(.center)

                    Text("Générateur de noms de code")
                        .font(.title3)
                        .fontWeight(.medium)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                }
                .padding(.horizontal)
                
                Spacer()
                
                NavigationLink(value: "CodeNameList") {
                    VStack(spacing: 16) {
                        Image(systemName: "arrow.triangle.2.circlepath")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundStyle(.green)
                            .frame(width: 200, height: 200)

                        Text("Générer")
                            .font(.title)
                            .fontWeight(.semibold)
                    }
                }
                
                Spacer()

                Text("v1.0")
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }
            .padding()
            .navigationDestination(for: String.self) { value in
                if value == "CodeNameList" {
                    CodeNameListView()
                }
            }
        }
    }
}

#Preview {
    LaunchView()
        .preferredColorScheme(.dark)
}
