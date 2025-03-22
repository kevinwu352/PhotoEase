//
//  PhotoListViewModel.swift
//  PhotoEase
//
//  Created by Kevin Wu on 3/21/25.
//

import SwiftUI
import Combine

//  {
//    "albumId": 1,
//    "id": 3,
//    "title": "officia porro iure quia iusto qui ipsa ut modi",
//    "url": "https://via.placeholder.com/600/24f355",
//    "thumbnailUrl": "https://via.placeholder.com/150/24f355"
//  }
struct Photo: Codable, Hashable, Identifiable {
    var albumId: Int
    var id: Int
    var title: String
    var url: String
    var thumbnailUrl: String

    var favorite = false

    enum CodingKeys: CodingKey {
        case albumId
        case id
        case title
        case url
        case thumbnailUrl
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

class PhotoListViewModel: ObservableObject {
    lazy var cancellables = Set<AnyCancellable>()

    @Published var allPhotos: [Photo] = []

    @Published var showFavoriteOnly = false
    @Published var photoList: [Photo] = []

    @Published var searchText: String?
    @Published var filteredList: [Photo] = []

    init() {
        bindData()
        loadPhotos()
    }
}

extension PhotoListViewModel {

    func bindData() {
        $allPhotos
            .dropFirst()
            .combineLatest($showFavoriteOnly)
            .sink { [weak self] list, show in
                if show {
                    self?.photoList = list.filter { $0.favorite }
                } else {
                    self?.photoList = list
                }
            }
            .store(in: &cancellables)

        $allPhotos
            .dropFirst()
            .combineLatest($searchText)
            .sink { [weak self] list, text in
                if let text = text, !text.isEmpty {
                    let text = text
                        .lowercased()
                        .trimmingCharacters(in: .whitespacesAndNewlines)
                    self?.filteredList = list
                        .filter {
                            $0.title.lowercased().contains(text)
                        }
                } else {
                    self?.filteredList = list
                }
            }
            .store(in: &cancellables)
    }

    func loadPhotos() {
//        let addr = "https://jsonplaceholder.typicode.com/photos"
//        URLSession.shared.dataTaskPublisher(for: addr.url!)
//            .timeout(.seconds(10), scheduler: DispatchQueue.userInitiated)
//            .map { $0.data }
//            .replaceError(with: Data())
//            .replaceNil(with: Data())
//            .replaceEmpty(with: Data())
        Just((try? Data(contentsOf: Bundle.main.url(forResource: "photos", withExtension: "json")!)) ?? Data())
            .delay(for: .seconds(0.5), scheduler: DispatchQueue.userInitiated)
            .decode(type: [Photo].self, decoder: JSONDecoder())
            .replaceError(with: [])
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                let list = $0.map {
                    var m = $0
                    m.url = m.url.replacingOccurrences(of: "via.placeholder.com", with: "dummyimage.com")
                    m.thumbnailUrl = m.thumbnailUrl.replacingOccurrences(of: "via.placeholder.com", with: "dummyimage.com")
                    return m
                }
                self?.allPhotos = list
            }
            .store(in: &cancellables)
    }

    func photoFavorite(_ photo: Photo?) {
        if let i = allPhotos.firstIndex(where: { $0.id == photo?.id }) {
            allPhotos[i].favorite.toggle()
        }
    }

}
