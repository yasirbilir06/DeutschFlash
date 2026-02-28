import Foundation

struct Word: Identifiable, Codable {
    let id = UUID()
    let german: String
    let article: String
    let turkish: String
    let category: String
    let emoji: String
    
    enum CodingKeys: String, CodingKey {
        case german
        case article
        case turkish
        case category
        case emoji
    }
}
