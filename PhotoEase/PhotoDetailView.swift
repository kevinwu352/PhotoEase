//
//  PhotoDetailView.swift
//  PhotoEase
//
//  Created by Kevin Wu on 3/21/25.
//

import SwiftUI

struct PhotoDetailView: View {

    var photo: Photo

    var body: some View {
        Text(photo.title)
            .navigationTitle("Photo Detail")
    }
}

#Preview {
    PhotoDetailView(photo: .init(albumId: 1, id: 1, title: "abc", url: "", thumbnailUrl: ""))
}
