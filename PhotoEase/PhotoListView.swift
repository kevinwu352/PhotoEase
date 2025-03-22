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
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("", systemImage: vm.showFavoriteOnly ? "star.fill" : "star") {
                    vm.showFavoriteOnly.toggle()
                }
            }
        }
    }

}

#Preview {
    NavigationStack {
        PhotoListView()
    }
}
