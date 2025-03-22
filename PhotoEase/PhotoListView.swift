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
        List(vm.photoList) { photo in
            NavigationLink(value: Route.detail(photo)) {
                PhotoListRowView(photo: photo, vm: vm)
            }
            .listRowBackground(Color.clear)
        }
        .listStyle(.plain)
        .background(Color.white)
        .environment(\.defaultMinListRowHeight, 80)
        .navigationTitle("Photo List")
        .navigationDestination(for: Route.self) {
            switch $0 {
            case let .detail(photo):
                PhotoDetailView(photo: photo, vm: vm)
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("", systemImage: vm.showFavoriteOnly ? "star.fill" : "star") {
                    vm.showFavoriteOnly.toggle()
                }
            }
        }
    }
}

extension PhotoListView {
    enum Route: Equatable, Hashable {
        case detail(_ photo: Photo)
    }
}

#Preview {
    NavigationStack {
        PhotoListView()
    }
}
