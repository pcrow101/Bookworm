//
//  AddBookView.swift
//  Bookworm
//
//  Created by paucrow on 08/07/2022.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss

    @State private var title = ""
    @State private var author = ""
    @State private var rating = 1
    @State private var genre = ""
    @State private var review = ""
    @State private var date = Date()
    @State private var showingAlert = false

    let genres = ["Fantasy", "Horror", "Kids", "Mystory", "Poetry", "Romance", "Thriller", "Unknown"]

    var body: some View {
        NavigationView{
            Form {
                Section {
                    TextField("Name of book", text: $title)
                    TextField("Author's name", text: $author)
                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                    DatePicker(selection: $date, in: ...Date(), displayedComponents: .date) {
                        Text("Select a date")
                    }
                }
                Section {
                    TextEditor(text: $review)
                    RatingView(rating: $rating)
                } header: {
                    Text("Write a review")
                }

                Section {
                    Button("Save"){
                        let newBook = Book(context: moc)
                        newBook.id = UUID()
                        newBook.title = (title == "") ? "unknown" : title
                        newBook.author = (author == "") ? "unknown" : author
                        newBook.rating = Int16(rating)
                        newBook.genre = (genre == "") ? "Unknown" : genre
                        newBook.review = (review == "") ? "No review yet" : review
                        newBook.date = date


                        try? moc.save()
                        dismiss()
                    }
                }
            }
            .navigationBarTitle("Add Book")
        }
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}
