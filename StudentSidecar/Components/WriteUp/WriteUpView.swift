//
//  WriteUpView.swift
//  StudentSidecar
//
//  Created by Jonathan Bijos on 11/06/24.
//

import SwiftUI
import ComposableArchitecture

@ObservableState
struct WriteUpModel: Homework, Equatable, Codable {
    var text: String = ""

    var isComplete: Bool {
        return !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}

@Reducer
struct WriteUpFeature {
    @ObservableState
    struct State {
        @Shared var model: WriteUpModel
    }

    enum Action: BindableAction {
        case binding(BindingAction<State>)
    }

    var body: some Reducer<State, Action> {
        BindingReducer()
    }
}

struct WriteUpView: View {
    @Bindable var store: StoreOf<WriteUpFeature>

    var body: some View {
        containerView
            .navigationTitle("Write up!")
    }

    var containerView: some View {
        TextEditor(text: $store.model.text)
            .foregroundStyle(.secondary)
            .padding(.horizontal)
    }
}

#Preview {
    WriteUpView(
        store: Store(
            initialState: WriteUpFeature.State(
                model: Shared(WriteUpModel())
            )
        ) {
            WriteUpFeature()
        }
    )
}
