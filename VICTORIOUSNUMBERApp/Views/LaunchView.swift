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
                        .font(.system(size: 34, weight: .heavy, design: .rounded))
                        .foregroundStyle(
                            LinearGradient(
                                colors: [.green, .blue],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .multilineTextAlignment(.center)

                    Text("Générateur de noms de code tactiques")
                        .font(.title3)
                        .fontWeight(.medium)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                }
                .padding(.horizontal)
                
                Spacer()
                
                NavigationLink(destination: CodeNameListView()) {
                    VStack {
                        Image(systemName: "bolt.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 80, height: 80)
                            .foregroundColor(.white)
                            .shadow(radius: 10)
                            .scaleEffect(isAnimating ? 1.1 : 1.0)
                            .animation(.easeInOut(duration: 1).repeatForever(autoreverses: true), value: isAnimating)

                        Text("Démarrer")
                            .font(.headline)
                            .foregroundColor(.white)
                    }
                    .frame(width: 160, height: 160)
                    .background(Color.green.gradient)
                    .clipShape(Circle())
                    .shadow(color: .green.opacity(0.4), radius: 10, x: 0, y: 5)
                }
                .onAppear {
                    isAnimating = true
                }
                
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
