//
//  PhotoListRowView.swift
//  PhotoEase
//
//  Created by Kevin Wu on 3/22/25.
//

import SwiftUI

struct PhotoListRowView: View {
    var photo: Photo

    var body: some View {
        HStack {
            Image(systemName: "heart.fill")
                .frame(width: 50, height: 50)
                .background(Color.gray)

            Text(photo.title)
                .lineLimit(2)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.gray)
        }
        .listRowBackground(Color.clear)
    }

}

#Preview(traits: .sizeThatFitsLayout) {
    PhotoListRowView(photo:
            .init(albumId: 1, id: 1, title: "ttl", url: "url1", thumbnailUrl: "url2")
    )
}
