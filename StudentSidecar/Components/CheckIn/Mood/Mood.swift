//
//  Mood.swift
//  StudentSidecar
//
//  Created by Jonathan Bijos on 19/06/24.
//

import Foundation

enum Mood: String, Codable, Identifiable, CaseIterable {
    var id: RawValue { rawValue }

    case 😁
    case 🙂
    case 😐
    case 🙁
    case 😭
}
