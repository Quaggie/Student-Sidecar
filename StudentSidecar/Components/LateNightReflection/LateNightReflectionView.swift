//
//  LateNightReflectionView.swift
//  StudentSidecar
//
//  Created by Jonathan Bijos on 20/06/24.
//

import SwiftUI
import ComposableArchitecture

@ObservableState
struct LateNightReflection: Homework, Equatable, Codable {
    var gratefulText: String = ""
    var interestingText: String = ""
    var handledText: String = ""
    var tomorrowText: String = ""

    var isComplete: Bool {
        !gratefulText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        && !interestingText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        && !handledText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        && !tomorrowText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}

@Reducer
struct LateNightReflectionFeature {
    @ObservableState
    struct State {
        @Shared var lateNightReflection: LateNightReflection
    }

    enum Action: BindableAction {
        case binding(BindingAction<State>)
    }

    var body: some Reducer<State, Action> {
        BindingReducer()
    }
}

struct LateNightReflectionView: View {
    @Bindable var store: StoreOf<LateNightReflectionFeature>

    var body: some View {
        containerView
            .navigationTitle("Late Night Reflections")
    }

    var containerView: some View {
        Form {
            Section("Today, I am grateful for...") {
                TextEditor(text: $store.lateNightReflection.gratefulText)
            }
            Section("One interesting thing that happened today was...") {
                TextEditor(text: $store.lateNightReflection.interestingText)
            }
            Section("I handled the situation well when...") {
                TextEditor(text: $store.lateNightReflection.handledText)
            }
            Section("Tomorrow, I will focus on...") {
                TextEditor(text: $store.lateNightReflection.tomorrowText)
            }
        }
    }
}

#Preview {
    NavigationStack {
        LateNightReflectionView(
            store: Store(
                initialState: LateNightReflectionFeature.State(
                    lateNightReflection: Shared(LateNightReflection())
                )
            ) {
                LateNightReflectionFeature()
            }
        )
    }
}
