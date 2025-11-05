//
//  CodeNameViewModel.swift
//  VICTORIOUSNUMBER
//
//  Created by Jules on 05/11/2025.
//

import SwiftUI

fileprivate struct WordPayload: Decodable {
    let adjectives: [String]?
    let nouns: [String]?

    var words: [String] {
        adjectives ?? nouns ?? []
    }
}

class CodeNameViewModel: ObservableObject {
    @Published var codeNames: [String] = []

    private var adjectives: [String] = []
    private var nouns: [String] = []

    init() {
        loadData()
    }

    func loadData() {
        adjectives = loadWords(from: "adjectives")
        nouns = loadWords(from: "nouns")
    }

    private func loadWords(from fileName: String) -> [String] {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            fatalError("Failed to locate \(fileName).json in bundle.")
        }

        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(fileName).json from bundle.")
        }

        let decoder = JSONDecoder()

        guard let payload = try? decoder.decode(WordPayload.self, from: data) else {
            fatalError("Failed to decode \(fileName).json from bundle.")
        }

        return payload.words
    }

    func generateCodeNames() {
        guard !adjectives.isEmpty, !nouns.isEmpty else {
            codeNames = [] // Clear previous names if data is missing
            return
        }

        var newCodeNames = Set<String>()
        let maxPossibleNames = adjectives.count * nouns.count
        let targetNameCount = min(10, maxPossibleNames)

        // Add a safeguard against potential infinite loops if random collisions are frequent
        var attempts = 0
        let maxAttempts = targetNameCount * 5 // Allow for some collisions

        while newCodeNames.count < targetNameCount && attempts < maxAttempts {
            if let adj = adjectives.randomElement(),
               let noun = nouns.randomElement() {
                // Add a space for better readability
                newCodeNames.insert("\(adj) \(noun)")
            }
            attempts += 1
        }

        codeNames = Array(newCodeNames)
    }
}
