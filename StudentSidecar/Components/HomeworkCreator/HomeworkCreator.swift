//
//  HomeworkCreator.swift
//  StudentSidecar
//
//  Created by Jonathan Bijos on 20/06/24.
//

import SwiftUI
import ComposableArchitecture

// WIP; Not added anywhere yet
@ObservableState
struct HomeworkCreatorModel: Equatable, Identifiable {
    var id = UUID()

    let title: String
    let placeholder: String
    var text: String
}

@Reducer
struct HomeworkCreatorFeature {
    @ObservableState
    struct State: Equatable {
        var homeworks: [HomeworkCreatorModel] = []
    }

    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case addButtonTapped
    }

    var body: some Reducer<State, Action> {
        BindingReducer()

        Reduce { state, action in
            switch action {
            case .binding:
                return .none
            case .addButtonTapped:
                state.homeworks.append(
                    HomeworkCreatorModel(title: "Something new here", placeholder: "", text: "")
                )
                return .none
            }
        }
    }
}

struct HomeworkCreatorView: View {
    @Bindable var store: StoreOf<HomeworkCreatorFeature>

    var body: some View {
        NavigationStack {
            containerView
                .navigationTitle("Homework creator")
                .toolbar {
                    Button {
                        store.send(.addButtonTapped)
                    } label: {
                        Image(systemName: "plus")
                    }
                }
        }
    }

    var containerView: some View {
        Form {
            ForEach($store.homeworks) { $homework in
                Section(homework.title) {
                    TextField(homework.placeholder, text: $homework.text)
                }
            }
        }
    }
}

#Preview {
    HomeworkCreatorView(
        store: Store(
            initialState: HomeworkCreatorFeature.State()
        ) {
            HomeworkCreatorFeature()
        }
    )
}
