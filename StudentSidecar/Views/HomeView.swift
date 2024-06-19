//
//  HomeView.swift
//  StudentSidecar
//
//  Created by Jonathan Bijos on 11/06/24.
//

import SwiftUI
import ComposableArchitecture

@ObservableState
struct HomeworkModel {
    var checkInModel: WriteUpModel
    var bookReviewModel: WriteUpModel
    var lateNightReflectionModel: WriteUpModel
}

@Reducer
struct HomeFeature {
    @Reducer
    enum Path {
        case writeUp(WriteUpFeature)
    }
    @Reducer
    enum Destination {
        case exportToPDF(ExportToPDFFeature)
    }

    @ObservableState
    struct State {
        var path = StackState<Path.State>()
        @Presents var destination: Destination.State?
        var selectedDate: Date = Date()
        @Shared var homeworkModel: HomeworkModel
    }

    enum Action: BindableAction {
        case path(StackActionOf<Path>)
        case destination(PresentationAction<Destination.Action>)
        case binding(BindingAction<State>)
        case setDateToToday
        case exportToPDFButtonTapped
        case checkInTapped
        case bookReviewTapped
        case lateNightReflectionTapped
    }

    @Dependency(\.date) var date

    var body: some Reducer<State, Action> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .path:
                return .none
            case .destination:
                return .none
            case .binding:
                return .none
            case .setDateToToday:
                state.selectedDate = date.now
                return .none
            case .exportToPDFButtonTapped:
                state.destination = .exportToPDF(
                    ExportToPDFFeature.State()
                )
                return .none
            case .checkInTapped:
                state.path.append(
                    .writeUp(
                        WriteUpFeature.State(model: state.$homeworkModel.checkInModel)
                    )
                )
                return .none
            case .bookReviewTapped:
                state.path.append(
                    .writeUp(
                        WriteUpFeature.State(model: state.$homeworkModel.bookReviewModel)
                    )
                )
                return .none
            case .lateNightReflectionTapped:
                state.path.append(
                    .writeUp(
                        WriteUpFeature.State(model: state.$homeworkModel.lateNightReflectionModel)
                    )
                )
                return .none
            }
        }
        .forEach(\.path, action: \.path)
        .ifLet(\.$destination, action: \.destination)
    }
}

struct HomeView: View {
    @Bindable var store: StoreOf<HomeFeature>
    @Environment(\.calendar) var calendar

    var body: some View {
        NavigationStack(
            path: $store.scope(state: \.path, action: \.path)
        ) {
            mainView
                .sheet(item: $store.scope(state: \.destination?.exportToPDF, action: \.destination.exportToPDF)) { exportToPDFStore in
                    ExportToPDFView(
                        store: exportToPDFStore
                    )
                }
        } destination: { store in
            switch store.case {
            case let .writeUp(store):
                WriteUpView(store: store)
            }
        }
    }

    var mainView: some View {
        List {
            homeworksSection
        }
        .navigationTitle("Monday")
        .toolbar {
            toolbarItems
        }
    }

    @ViewBuilder
    var toolbarItems: some View {
        if !calendar.isDateInToday(store.selectedDate) {
            Button {
                store.send(.setDateToToday)
            } label: {
                Text("Today")
            }
        }
        DatePicker(selection: $store.selectedDate, in: ...Date.now, displayedComponents: .date) {
            Label("Calendar", systemImage: "calendar")
        }
        .datePickerStyle(CompactDatePickerStyle())
    }

    var homeworksSection: some View {
        Section {
            HomeworkRowButton(
                image: "checkmark",
                text: "Check in",
                isComplete: store.state.homeworkModel.checkInModel.hasText
            ) {
                store.send(.checkInTapped)
            }
            HomeworkRowButton(
                image: "book",
                text: "Book Review",
                isComplete: store.state.homeworkModel.bookReviewModel.hasText
            ) {
                store.send(.bookReviewTapped)
            }
            HomeworkRowButton(
                image: "moon",
                text: "Late night reflection",
                isComplete: store.state.homeworkModel.lateNightReflectionModel.hasText
            ) {
                store.send(.lateNightReflectionTapped)
            }
        } header: {
            Text("Complete your homework")
        } footer: {
            ExportButton {
                store.send(.exportToPDFButtonTapped)
            }
        }
    }
}

#Preview {
    HomeView(
        store: Store(
            initialState: HomeFeature.State(
                homeworkModel: Shared(
                    HomeworkModel(
                        checkInModel: WriteUpModel(),
                        bookReviewModel: WriteUpModel(),
                        lateNightReflectionModel: WriteUpModel()
                    )
                )
            )
        ) {
            HomeFeature()
        }
    )
}
