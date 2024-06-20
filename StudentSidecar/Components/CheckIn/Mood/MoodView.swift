//
//  MoodView.swift
//  StudentSidecar
//
//  Created by Jonathan Bijos on 19/06/24.
//

import SwiftUI

struct MoodView: View {
    let moods: [Mood] = Mood.allCases
    @Binding var selectedMood: Mood?

    var body: some View {
        HStack(spacing: 16) {
            ForEach(Mood.allCases) { mood in
                emojiButton(mood: mood)
            }
        }
    }

    func emojiButton(mood: Mood) -> some View {
        Button {
            if mood == selectedMood {
                selectedMood = nil
            } else {
                selectedMood = mood
            }
        } label: {
            Text(mood.rawValue)
                .scaleEffect(selectedMood == mood ? CGSize(width: 1.5, height: 1.5) : CGSize(width: 1, height: 1))
                .animation(.spring.speed(2.5), value: selectedMood)
                .transition(.scale)
        }
    }
}

#Preview {
    @State var selectedMood: Mood? = .😐
    return MoodView(selectedMood: $selectedMood)
}
