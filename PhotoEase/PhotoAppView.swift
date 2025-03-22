//
//  PhotoAppView.swift
//  PhotoEase
//
//  Created by Kevin Wu on 3/21/25.
//

import SwiftUI

struct PhotoAppView: View {
    var body: some View {
        NavigationLink(value: 1) {
            Text("run")
        }
        .navigationTitle("Photo App")
        .navigationDestination(for: Int.self) { v in
            PhotoListView()
        }
    }
}

#Preview {
    PhotoAppView()
}
