//
//  Home+Storage.swift
//  StudentSidecar
//
//  Created by Jonathan Bijos on 20/06/24.
//

import Foundation
import ComposableArchitecture

extension PersistenceKey where Self == PersistenceKeyDefault<FileStorageKey<HomeworkModel>> {
    static var homeworkModel: Self {
        PersistenceKeyDefault(
            .fileStorage(.homeworkModel),
            HomeworkModel()
        )
    }
}

private extension URL {
    static let homeworkModel = Self.documentsDirectory
      .appendingPathComponent("homework-model")
      .appendingPathExtension("json")
}
