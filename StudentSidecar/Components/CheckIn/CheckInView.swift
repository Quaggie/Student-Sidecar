//
//  CheckInView.swift
//  StudentSidecar
//
//  Created by Jonathan Bijos on 19/06/24.
//

import ComposableArchitecture
import SwiftUI

@ObservableState
struct CheckIn: Homework, Equatable, Codable {
    var selectedMood: Mood?
    var accomplishmentText: String = ""
    var feelingText: String = ""
    var affirmationText: String = ""

    var isComplete: Bool {
        selectedMood != nil
        && !accomplishmentText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        && !feelingText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        && !affirmationText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}

@Reducer
struct CheckkInFeature {
    @ObservableState
    struct State {
        @Shared var checkIn: CheckIn
    }

    enum Action: BindableAction {
        case binding(BindingAction<State>)
    }

    var body: some Reducer<State, Action> {
        BindingReducer()
    }
}

struct CheckInView: View {
    @Bindable var store: StoreOf<CheckkInFeature>

    var body: some View {
        containerView
            .navigationTitle("Check In")
            .scrollDismissesKeyboard(.interactively)
    }

    var containerView: some View {
        Form {
            Section("I woke up feeling") {
                MoodView(selectedMood: $store.checkIn.selectedMood)
                    .buttonStyle(.plain)
            }

            Section("What do you want to accomplish today?") {
                TextEditor(text: $store.checkIn.accomplishmentText)
            }

            Section("How do you want to feel today?") {
                TextEditor(text: $store.checkIn.feelingText)
            }

            Section("Today's affirmation") {
                TextEditor(text: $store.checkIn.affirmationText)
                    .padding()
            }
        }
    }
}

#Preview {
    NavigationStack {
        CheckInView(
            store: Store(
                initialState: CheckkInFeature.State(
                    checkIn: Shared(
                        CheckIn()
                    )
                )
            ) {
                CheckkInFeature()
            }
        )
    }
}
