//
//  deps.swift
//  PhotoEase
//
//  Created by Kevin Wu on 3/22/25.
//

import SwiftUI

public extension String {
    var url: URL? {
        URL(string: self)
    }
}

public extension DispatchQueue {
    static var userInteractive: DispatchQueue { .global(qos: .userInteractive) }
    static var userInitiated: DispatchQueue { .global(qos: .userInitiated) }
    static var `default`: DispatchQueue { .global(qos: .default) }
    static var utility: DispatchQueue { .global(qos: .utility) }
    static var background: DispatchQueue { .global(qos: .background) }
}
