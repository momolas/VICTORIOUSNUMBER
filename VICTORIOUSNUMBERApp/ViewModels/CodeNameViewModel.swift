
import SwiftUI
import Observation
import OSLog
import RegexBuilder

@Observable
class CodeNameViewModel {
    var codeNames: [String] = []
    var isLoading: Bool = false
    var errorMessage: String? = nil

    private var adjectives: [String] = []
    private var nouns: [String] = []

    private let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "com.VICTORIOUSNUMBER", category: "CodeNameViewModel")

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
        logger.debug("Started loading data.")

        defer { isLoading = false }

        do {
            async let adjectivesLoad = loadWords(from: Constants.adjectivesFileName)
            async let nounsLoad = loadWords(from: Constants.nounsFileName)

            adjectives = try await adjectivesLoad
            nouns = try await nounsLoad

            logger.info("Successfully loaded \(self.adjectives.count) adjectives and \(self.nouns.count) nouns.")
        } catch {
            logger.error("Failed to load data: \(error.localizedDescription)")
            errorMessage = Constants.loadErrorMessage
        }
    }

    private func loadWords(from fileName: String) async throws -> [String] {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: Constants.jsonExtension) else {
            logger.error("File not found: \(fileName).json")
            throw URLError(.fileDoesNotExist)
        }

        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        let payload = try decoder.decode(WordPayload.self, from: data)

        // Use RegexBuilder to ensure words only contain letters (no numbers or symbols)
        let wordValidationRegex = Regex {
            Anchor.startOfLine
            OneOrMore(.word)
            Anchor.endOfLine
        }

        let validWords = payload.words.filter { word in
            let isValid = word.wholeMatch(of: wordValidationRegex) != nil
            if !isValid {
                logger.warning("Excluded invalid word: \(word) in \(fileName)")
            }
            return isValid
        }

        return validWords
    }

    func generateCodeNames() {
        guard !adjectives.isEmpty, !nouns.isEmpty else {
            logger.warning("Attempted to generate names with empty word lists.")
            // Attempt to reload if empty (maybe failed previously)
             if errorMessage != nil {
                 logger.info("Retrying data load...")
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

        if newCodeNames.count < targetNameCount {
             logger.warning("Could only generate \(newCodeNames.count) unique names after \(attempts) attempts.")
        }

        codeNames = Array(newCodeNames).sorted()
        logger.debug("Generated \(self.codeNames.count) code names.")
    }
}

fileprivate struct WordPayload: Decodable {
    let adjectives: [String]?
    let nouns: [String]?

    var words: [String] {
        adjectives ?? nouns ?? []
    }
}
