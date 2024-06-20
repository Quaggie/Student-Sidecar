//
//  StudentSidecarApp.swift
//  StudentSidecar
//
//  Created by Jonathan Bijos on 11/06/24.
//

import SwiftUI
import ComposableArchitecture

@main
struct StudentSidecarApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView(
                store: Store(
                    initialState: HomeFeature.State(
                        homeworkModel: Shared(
                            HomeworkModel(
                                checkInModel: CheckIn(),
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
    }
}
