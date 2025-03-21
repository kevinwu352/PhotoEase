//
//  PhotoAppView.swift
//  PhotoEase
//
//  Created by Kevin Wu on 3/21/25.
//

import SwiftUI

struct PhotoAppView: View {
    var body: some View {
        NavigationStack {
            NavigationLink("rock", destination: PhotoListView())
                .navigationTitle("Photo App")
        }
    }
}

#Preview {
    PhotoAppView()
}
