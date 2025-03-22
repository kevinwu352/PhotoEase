//
//  Route.swift
//  PhotoEase
//
//  Created by Kevin Wu on 3/22/25.
//

import SwiftUI

enum Route: Equatable, Hashable {

    case app
    case list
    case detail(_ photo: Photo)

    var name: String {
        switch self {
        case .app: return "app"
        case .list: return "list"
        case .detail: return "detail"
        }
    }

    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.name == rhs.name
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }

    @ViewBuilder var view: some View {
        switch self {
        case .app:
            PhotoAppView()
        case .list:
            PhotoListView()
        case let .detail(photo):
            PhotoDetailView(photo: photo)
        }
    }

}
