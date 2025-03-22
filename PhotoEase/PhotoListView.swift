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
            NavigationLink(value: Route.detail(photo)) {
                PhotoListRowView(photo: photo)
            }
        }
        .listStyle(.plain)
        .environment(\.defaultMinListRowHeight, 80)
        .navigationTitle("Photo List")
    }

}

#Preview {
    PhotoListView()
}
