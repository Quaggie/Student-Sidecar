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
                        checkInModel: Shared(WriteUpModel()),
                        bookReviewModel: Shared(WriteUpModel()),
                        lateNightReflectionModel: Shared(WriteUpModel())
                    )
                ) {
                    HomeFeature()
                }
            )
        }
    }
}
