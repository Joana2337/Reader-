
import Foundation

// Google Books API Models
struct GoogleBookResult: Codable {  // Changed from BookResult to GoogleBookResult
    let items: [GoogleBook]
}

struct GoogleBook: Identifiable, Codable {
    let id: String
    let volumeInfo: GoogleVolumeInfo
}

struct GoogleVolumeInfo: Codable {
    let title: String
    let authors: [String]?
    let description: String?
    let imageLinks: GoogleImageLinks?
    
    var authorDisplay: String {
        authors?.joined(separator: ", ") ?? "Unknown Author"
    }
}

struct GoogleImageLinks: Codable {
    let smallThumbnail: String?
    let thumbnail: String?
    
    var secureImageURL: URL? {
        guard let thumbnail = thumbnail else { return nil }
        let secureURL = thumbnail.replacingOccurrences(of: "http://", with: "https://")
        return URL(string: secureURL)
    }
}
