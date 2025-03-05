
//  HomeView.swift
//  Reader
//  Created by Joanne on 3/4/25.

import SwiftUI

struct HomeView: View {
   @State private var searchText = ""
   @State private var books: [Book] = []
   let booksService = GoogleBooksService()
   
   var body: some View {
       NavigationView {
           VStack {
               // Search Bar
               SearchBar(text: $searchText, onCommit: searchBooks)
                   .padding()
               
               // Search Results
               if !books.isEmpty {
                   List(books) { book in
                       HStack {
                           VStack(alignment: .leading) {
                               Text(book.volumeInfo.title)
                               Text(book.volumeInfo.authors.first ?? "Unknown Author")
                                   .font(.caption)
                           }
                           
                           Spacer()
                           
                           HStack {
                               Button(action: { addToCurrentlyReading(book) }) {
                                   Image(systemName: "book.fill")
                               }
                               
                               Button(action: { addToWantToRead(book) }) {
                                   Image(systemName: "bookmark.fill")
                               }
                           }
                       }
                   }
               }
               
               // Quick Access Sections
               ScrollView {
                   VStack(alignment: .leading, spacing: 20) {
                       // Currently Reading Section
                       QuickAccessSection(
                           title: "Currently Reading",
                           destination: CurrentlyReadingView()
                       )
                       
                       // Want to Read Section
                       QuickAccessSection(
                           title: "Want to Read",
                           destination: WantToReadView()
                       )
                   }
                   .padding()
               }
           }
           .navigationTitle("Reader")
       }
   }
   
   func searchBooks() {
       booksService.searchBooks(query: searchText) { fetchedBooks in
           self.books = fetchedBooks
       }
   }
   
   func addToCurrentlyReading(_ book: Book) {
       print("Added to Currently Reading: \(book.volumeInfo.title)")
       // TODO: Implement CloudKit save
   }
   
   func addToWantToRead(_ book: Book) {
       print("Added to Want to Read: \(book.volumeInfo.title)")
       // TODO: Implement CloudKit save
   }
}

// Search Bar
struct SearchBar: View {
   @Binding var text: String
   var onCommit: (() -> Void)?
   
   var body: some View {
       HStack {
           Image(systemName: "magnifyingglass")
               .foregroundColor(.gray)
           
           TextField("Search Books", text: $text, onCommit: { onCommit?() })

       }
       .padding(8)
       .background(Color(.systemGray6))
       .cornerRadius(10)
   }
}


// Quick Access Section Component
struct QuickAccessSection<Destination: View>: View {
   let title: String
   let destination: Destination
   
   var body: some View {
       NavigationLink(destination: destination) {
           HStack {
               Image(systemName: "plus.circle.fill")
                   .foregroundColor(.blue)
               
               Text(title)
                   .fontWeight(.semibold)
               
               Spacer()
               
               Image(systemName: "chevron.right")
                   .foregroundColor(.gray)
           }
           .padding()
           .background(Color(.systemBackground))
           .cornerRadius(10)
           .shadow(color: .gray.opacity(0.2), radius: 5, x: 0, y: 2)
       }
       .buttonStyle(PlainButtonStyle())
   }
}

// Placeholder Views for Navigation
struct CurrentlyReadingView: View {
   var body: some View {
       Text("Currently Reading")
           .navigationTitle("Currently Reading")
   }
}

struct WantToReadView: View {
   var body: some View {
       Text("Want to Read")
           .navigationTitle("Want to Read")
   }
}

struct HomeView_Previews: PreviewProvider {
   static var previews: some View {
       HomeView()
   }
}


//things to fix..currently reading and want to read needs to be an add button. All what there're to do is let me either add a book up to either currently reading or want to read. search bar does list books alright but clicking on it does nothing - its supposed to show authors info and book info if I click on them.
