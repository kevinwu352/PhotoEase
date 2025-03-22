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
            AsyncImage(url: photo.thumbnailUrl.url) {
                $0.resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .cornerRadius(25)
                    .shadow(radius: 3.0)
            } placeholder: {
                ProgressView()
            }
            .frame(width: 50, height: 50)

            Text(photo.title)
                .lineLimit(2)
                .frame(maxWidth: .infinity, alignment: .leading)
                .alignmentGuide(.listRowSeparatorLeading) {
                    $0[.leading]
                }

            Button("", systemImage: photo.favorite ? "star.fill" : "star") {
            }
            .foregroundStyle(Color.black)
        }
    }

}

#Preview(traits: .sizeThatFitsLayout) {
    PhotoListRowView(photo:
            .init(albumId: 1, id: 1, title: "ttl", url: "url1", thumbnailUrl: "url2")
    )
}
