//
//  PhotoListView.swift
//  PhotoEase
//
//  Created by Kevin Wu on 3/21/25.
//

import SwiftUI

struct PhotoListView: View {

    var body: some View {
        NavigationStack {
            List {
                ForEach(0..<50) { i in
                    ListCell(i: i)
                }
            }
            .listStyle(.plain)
            .environment(\.defaultMinListRowHeight, 80)
            .navigationTitle("Photo List")
        }
        .background(Color.green)
    }
}

struct ListCell: View {
    var i: Int

    var body: some View {
        HStack {
            Image(systemName: "heart.fill")
                .frame(width: 50, height: 50)
                .background(Color.gray)

            Text("\(i) You might want to set new insets relative to the original position. In that case")
                .lineLimit(2)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.gray)
        }
        .listRowBackground(Color.clear)
    }
}

#Preview {
    PhotoListView()
}
