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
            VStack {
                
                Spacer()
                
                Text("VICTORIOUSNUMBER")
                    .font(.largeTitle)
                
                Text("Une application pour générer des noms de code")
                    .font(.caption)
                
                Spacer()
                
//                NavigationLink(destination: CodeNameListView(wordList: WordList()),
				NavigationLink(destination: CodeNameListView(),
                               label: {
                    Image(systemName: "arrow.triangle.2.circlepath")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(.green)
                        .frame(width: 200, height: 200)
                })
                
                Spacer()
                Spacer()
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
	LaunchView()
        .preferredColorScheme(.dark)
}
