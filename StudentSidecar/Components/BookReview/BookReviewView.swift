//
//  BookReviewView.swift
//  StudentSidecar
//
//  Created by Jonathan Bijos on 20/06/24.
//

import ComposableArchitecture
import SwiftUI

@ObservableState
struct BookReview: Homework, Equatable, Codable {
    var titleText: String = ""
    var authorText: String = ""
    var genreText: String = ""
    var pagesText: String = ""
    var rating: Rating?
    var quoteText: String = ""
    var summaryText: String = ""
    var finalThoughtsText: String = ""

    var isComplete: Bool {
        !titleText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        && !authorText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        && !genreText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        && !pagesText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        && rating != nil
        && !quoteText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        && !summaryText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        && !finalThoughtsText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}

@Reducer
struct BookReviewFeature {
    @ObservableState
    struct State {
        @Shared var bookReview: BookReview
    }

    enum Action: BindableAction {
        case binding(BindingAction<State>)
    }

    var body: some Reducer<State, Action> {
        BindingReducer()
    }
}

struct BookReviewView: View {
    @Bindable var store: StoreOf<BookReviewFeature>

    var body: some View {
        containerView
            .navigationTitle("Book Review")
            .scrollDismissesKeyboard(.interactively)
    }

    var containerView: some View {
        List {
            Section("Title") {
                TextField("Ex: Game of Thrones", text: $store.bookReview.titleText)
            }

            Section("Author") {
                TextField("Ex: George R.R. Martin", text: $store.bookReview.authorText)
            }

            Section("Genre") {
                TextField("Ex: Romance", text: $store.bookReview.genreText)
            }

            Section("Pages") {
                TextField("Ex: 150", text: $store.bookReview.pagesText)
                    .keyboardType(.numberPad)
            }

            Section("Rating") {
                RatingView(selectedRating: $store.bookReview.rating)
                    .buttonStyle(.plain)
            }

            Section("Favorite Quote") {
                TextField("Ex: What do you say to the god of death?", text: $store.bookReview.quoteText)
            }

            Section("Summary") {
                TextField("Ex: Very confusing", text: $store.bookReview.summaryText)
            }

            Section("Final thoughts") {
                TextField("Ex: I really enjoyed it", text: $store.bookReview.finalThoughtsText)
            }
        }
    }
}

#Preview {
    NavigationStack {
        BookReviewView(
            store: Store(
                initialState: BookReviewFeature.State(
                    bookReview: Shared(
                        BookReview()
                    )
                )
            ) {
                BookReviewFeature()
            }
        )
    }
}
