//
//  ExportToPDFView.swift
//  StudentSidecar
//
//  Created by Jonathan Bijos on 14/06/24.
//

import SwiftUI
import ComposableArchitecture

@Reducer
struct ExportToPDFFeature {}

struct ExportToPDFView: View {
    let store: StoreOf<ExportToPDFFeature>

    var body: some View {
        Text("Export to PDF!")
    }
}
