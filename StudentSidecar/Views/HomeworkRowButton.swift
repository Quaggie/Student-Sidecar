//
//  HomeworkRow.swift
//  StudentSidecar
//
//  Created by Jonathan Bijos on 11/06/24.
//

import SwiftUI

struct HomeworkRowButton: View {
    let image: String
    let text: String
    let isComplete: Bool
    let action: () -> Void

    var fontWeight: Font.Weight {
        isComplete ? .semibold : .regular
    }

    var body: some View {
        Button(action: action, label: {
            HStack {
                Image(systemName: image)
                    .imageScale(.large)
                    .foregroundStyle(.primary)
                    .fontWeight(fontWeight)
                Text(text)
                    .foregroundStyle(.primary)
                    .font(.title3)
                    .fontWeight(fontWeight)
                Spacer()
                Image(systemName: "chevron.right")
                    .imageScale(.large)
                    .foregroundStyle(.primary)
                    .fontWeight(fontWeight)
            }
        })
        .tint(.primary)
    }
}

#Preview {
    VStack {
        HomeworkRowButton(image: "moon", text: "Late night done", isComplete: true, action: {})
        HomeworkRowButton(image: "moon", text: "Late night incomplete", isComplete: false, action: {})
    }
}
