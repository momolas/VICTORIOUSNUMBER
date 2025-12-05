//
//  ContentView.swift
//  Shared
//
//  Created by Mo on 28/01/2022.
//

import SwiftUI

struct LaunchView: View {
    @State private var isAnimating = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
                
                Spacer()
                
                VStack(spacing: 10) {
                    Text("VICTORIOUSNUMBER")
                        .font(.system(size: 32, weight: .heavy, design: .rounded))
                        .foregroundStyle(
                            LinearGradient(
                                colors: [.green, .blue],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .multilineTextAlignment(.center)

                    Text("Générateur de noms de code")
                        .font(.title3)
                        .fontWeight(.medium)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                }
                .padding(.horizontal)
                
                Spacer()
                
                NavigationLink(destination: CodeNameListView(),
                               label: {
                    Image(systemName: "arrow.triangle.2.circlepath")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(.green)
                        .frame(width: 200, height: 200)
                })
                
                Spacer()

                Text("v1.0")
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
            .padding()
            // Removed redundant .navigationBarTitleDisplayMode(.inline) to allow clean fullscreen look
        }
    }
}

#Preview {
	LaunchView()
        .preferredColorScheme(.dark)
}
