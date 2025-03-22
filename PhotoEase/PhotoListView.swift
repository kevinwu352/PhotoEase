//
//  PhotoListView.swift
//  PhotoEase
//
//  Created by Kevin Wu on 3/21/25.
//

import SwiftUI

struct PhotoListView: View {

    @StateObject var vm = PhotoListViewModel()

    var body: some View {
        List(vm.allPhotos) { photo in
            NavigationLink(value: photo) {
                PhotoListRowView(photo: photo)
            }
        }
        .listStyle(.plain)
        .environment(\.defaultMinListRowHeight, 80)
        .navigationDestination(for: Photo.self) { photo in
            PhotoDetailView(photo: photo)
        }
        .navigationTitle("Photo List")
    }

}

#Preview {
    PhotoListView()
}
