
import SwiftUI

class CodeNameViewModel: ObservableObject {
    @Published var codeNames: [String] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil

    private var adjectives: [String] = []
    private var nouns: [String] = []

    private enum Constants {
        static let adjectivesFileName = "adjectives"
        static let nounsFileName = "nouns"
        static let jsonExtension = "json"
        static let targetNameCount = 10
        static let maxAttemptsMultiplier = 5
        static let loadErrorMessage = "Impossible de charger les listes de mots. Veuillez réinstaller l'application."
    }

    init() {
        Task {
            await loadData()
        }
    }

    @MainActor
    func loadData() async {
        isLoading = true
        errorMessage = nil

        defer { isLoading = false }

        do {
            async let adjectivesLoad = loadWords(from: Constants.adjectivesFileName)
            async let nounsLoad = loadWords(from: Constants.nounsFileName)

            adjectives = try await adjectivesLoad
            nouns = try await nounsLoad
        } catch {
            errorMessage = Constants.loadErrorMessage
        }
    }

    private func loadWords(from fileName: String) async throws -> [String] {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: Constants.jsonExtension) else {
            throw URLError(.fileDoesNotExist)
        }

        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        let payload = try decoder.decode(WordPayload.self, from: data)
        return payload.words
    }

    func generateCodeNames() {
        guard !adjectives.isEmpty, !nouns.isEmpty else {
            // Attempt to reload if empty (maybe failed previously)
             if errorMessage != nil {
                 Task { await loadData() }
             }
            return
        }

        var newCodeNames = Set<String>()
        let maxPossibleNames = adjectives.count * nouns.count
        let targetNameCount = min(Constants.targetNameCount, maxPossibleNames)

        var attempts = 0
        let maxAttempts = targetNameCount * Constants.maxAttemptsMultiplier

        while newCodeNames.count < targetNameCount && attempts < maxAttempts {
            if let adj = adjectives.randomElement(),
               let noun = nouns.randomElement() {
                newCodeNames.insert("\(adj)\(noun)".uppercased())
            }
            attempts += 1
        }

        codeNames = Array(newCodeNames).sorted()
    }
}

fileprivate struct WordPayload: Decodable {
    let adjectives: [String]?
    let nouns: [String]?

    var words: [String] {
        adjectives ?? nouns ?? []
    }
}
