
//  BookModel.swift
//  Reader
//  Created by Joanne on 3/4/25.
//For searching books and fetching Google Books API results, a data model and service is created to handle the Api calls.

import Foundation
import SwiftData
import CloudKit


struct BookResult: Codable {
    let items: [Book]
}

struct Book: Codable, Identifiable {
    let id: String
    let volumeInfo: VolumeInfo
}

struct VolumeInfo: Codable {
    let title: String
    let authors: [String]
    let description: String?
    let imageLinks: ImageLinks?
}

struct ImageLinks: Codable {
    let thumbnail: String?
}



//where API calls and saving to CloudKit happens but integrating cloudkit to save books data crushes the app.
class GoogleBooksService {
    func searchBooks(query: String, completion: @escaping ([Book]) -> Void) {
        guard let url = URL(string: "https://www.googleapis.com/books/v1/volumes?q=\(query.urlEncoded)&key=\(APIKeys.googleBooksAPI)") else {
            completion([])
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                completion([])
                return
            }
            
            do {
                let bookResult = try JSONDecoder().decode(BookResult.self, from: data)
                DispatchQueue.main.async {
                    completion(bookResult.items)
                }
            } catch {
                print("Error decoding books: \(error)")
                completion([])
            }
        }.resume()
    }
}

extension String {
    var urlEncoded: String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? self
    }
}
