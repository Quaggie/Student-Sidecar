//
//  RatingView.swift
//  StudentSidecar
//
//  Created by Jonathan Bijos on 20/06/24.
//

import SwiftUI

struct RatingView: View {
    let ratings: [Rating] = Rating.allCases
    @Binding var selectedRating: Rating?

    var body: some View {
        HStack(spacing: 16) {
            ForEach(Rating.allCases) { rating in
                ratingButton(rating: rating)
            }
        }
    }

    func ratingButton(rating: Rating) -> some View {
        Button {
            if rating == selectedRating {
                selectedRating = nil
            } else {
                selectedRating = rating
            }
        } label: {
            Image(systemName: selectedRating?.rawValue ?? -1 >= rating.rawValue ? "star.fill" : "star")
                .animation(.easeInOut, value: selectedRating)
                .transition(.opacity)
        }
    }
}

#Preview {
    @State var selectedRating: Rating? = .fiveStars
    return RatingView(selectedRating: $selectedRating)
}

enum Rating: Int, Identifiable, CaseIterable {
    var id: RawValue { rawValue }

    case oneStar
    case twoStars
    case threeStars
    case fourStars
    case fiveStars
}
