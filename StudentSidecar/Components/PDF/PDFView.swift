//
//  PDFView.swift
//  StudentSidecar
//
//  Created by Jonathan Bijos on 18/06/24.
//

import ComposableArchitecture
import SwiftUI

@Reducer
struct PDFFeature {
    @ObservableState
    struct State {
        let selectedDate: Date
    }
}

@MainActor
struct PDFView<Container: View>: View {
    let store: StoreOf<PDFFeature>
    let container: Container

    var body: some View {
        ScrollView(.vertical) {
            container
                .padding()
        }.toolbar {
            ShareLink("Export", item: rendererURL())
        }
        .navigationTitle("PDF Viewer")
        .navigationBarTitleDisplayMode(.inline)
    }

    func rendererURL() -> URL {
        let renderer = ImageRenderer(content: container)
        let formattedDate = store.selectedDate.formatted(.dateTime.day().month().year())
        let url = URL.documentsDirectory.appending(path: "homeworks-\(formattedDate).pdf")

        renderer.render { size, context in
            var box = CGRect(x: 0, y: 0, width: size.width, height: size.height)

            guard let pdf = CGContext(url as CFURL, mediaBox: &box, nil) else { return }

            pdf.beginPDFPage(nil)

            context(pdf)

            pdf.endPDFPage()
            pdf.closePDF()
        }

        return url
    }
}
