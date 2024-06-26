//
//  Task+Ext.swift
//  sifantasysdk
//
//  Created by Vidyasagar Kodunuri on 21/04/24.
//

import SwiftUI

extension Task where Success == Never, Failure == Never {
    static func sleep(seconds: Double) async throws {
        let duration = UInt64(seconds * 1_000_000_000)
        try await Task.sleep(nanoseconds: duration)
    }
}
