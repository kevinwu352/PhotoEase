//
//  PhotoDetailView.swift
//  PhotoEase
//
//  Created by Kevin Wu on 3/21/25.
//

import SwiftUI

struct PhotoDetailView: View {
    @State var photo: Photo
    @ObservedObject var vm: PhotoListViewModel

    @State var showUnfavoriteAlert = false

    var body: some View {
        VStack(spacing: 20) {
            AsyncImage(url: photo.url.url) {
                $0.resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
            } placeholder: {
                ProgressView()
            }
            .frame(width: 300, height: 300)

            Text(photo.title)
                .padding(.horizontal, 24)
                .multilineTextAlignment(.center)
        }
        .navigationTitle("Photo Detail")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("", systemImage: photo.favorited ? "star.fill" : "star", action: favoritePhoto)
            }
        }
        .alert("Are you sure to dislike this photo?", isPresented: $showUnfavoriteAlert) {
            Button("Cancel", role: .cancel) { }
            Button("Sure", role: .destructive, action: doFavoritePhoto)
        } message: { }
    }

    func favoritePhoto() {
        if photo.favorited {
            showUnfavoriteAlert = true
        } else {
            doFavoritePhoto()
        }
    }

    func doFavoritePhoto() {
        photo.favorited.toggle()
        vm.favoritePhoto(photo)
    }
}

#Preview {
    PhotoDetailView(
        photo: .init(albumId: 1, id: 1, title: "ttl", url: "url1", thumbnailUrl: "url2"),
        vm: .init()
    )
}
