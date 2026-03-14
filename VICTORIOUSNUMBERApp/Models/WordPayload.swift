import Foundation

struct WordPayload: Decodable {
    let adjectives: [String]?
    let nouns: [String]?

    var words: [String] {
        adjectives ?? nouns ?? []
    }
}
