//
//  ExportButton.swift
//  StudentSidecar
//
//  Created by Jonathan Bijos on 11/06/24.
//

import SwiftUI

struct ExportButton: View {
    let action: () -> Void

    var body: some View {
        HStack {
            Spacer()
            VStack {
                Spacer()
                Button {
                    action()
                } label: {
                    Label("Export to PDF", systemImage: "square.and.arrow.up")
                }.tint(.primary)
            }
            Spacer()
        }
    }
}

#Preview {
    ExportButton {}
}
