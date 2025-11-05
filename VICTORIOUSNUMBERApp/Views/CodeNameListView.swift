//
//  ListView.swift
//  VICTORIOUSNUMBER
//
//  Created by Mo on 28/01/2022.
//

import SwiftUI

struct CodeNameListView: View {
	@State private var codeNames: [String] = []
	@State private var adjectives: [String] = []
	@State private var nouns: [String] = []
	
	var body: some View {
		NavigationView {
			VStack {
				
				Text("CODENAME")
					.font(.largeTitle)
				
				List(codeNames, id: \.self) { codename in
					Text(codename.uppercased())
						.font(.title2)
						.foregroundColor(.red)
				}
				.textSelection(.enabled)
				
				Button(action: {
					codeNames = generateCodeNames(adjectives: adjectives, nouns: nouns)
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
				// Chargement initial
				loadData()
			}
		}
	}
	
	func loadData() {
		adjectives = loadWords(from: "adjectives") // fichier local
		nouns = loadWords(from: "nouns") // fichier local
	}
	
	func loadWords(from fileName: String) -> [String] {
		guard let url = Bundle.main.url(forResource: fileName, withExtension: "json"),
			  let data = try? Data(contentsOf: url),
			  let json = try? JSONSerialization.jsonObject(with: data) as? [String: [String]] else {
			return []
		}
		return json["adjectives"] ?? json["nouns"] ?? []
	}
	
	func generateCodeNames(adjectives: [String], nouns: [String]) -> [String] {
		var codeNames = Set<String>()
		while codeNames.count < 10 {
			if let adj = adjectives.randomElement(),
				let noun = nouns.randomElement() {
				codeNames.insert("\(adj)\(noun)")
			}
		}
		return Array(codeNames)
	}
}

#Preview {
	//	CodeNameListView(wordList: WordList())
	CodeNameListView()
		.preferredColorScheme(.dark)
}
