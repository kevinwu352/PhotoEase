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
    @Published var allPhotos: [Photo] = [
        .init(albumId: 1, id: 1, title: "accusamus beatae ad facilis cum similique qui sunt", url: "https://dummyimage.com/600/92c952", thumbnailUrl: "https://dummyimage.com/150/92c952"),
        .init(albumId: 1, id: 2, title: "reprehenderit est deserunt velit ipsam", url: "https://dummyimage.com/600/771796", thumbnailUrl: "https://dummyimage.com/150/771796"),
        .init(albumId: 1, id: 3, title: "officia porro iure quia iusto qui ipsa ut modi", url: "https://dummyimage.com/600/24f355", thumbnailUrl: "https://dummyimage.com/150/24f355"),
    ]

    @Published var showFavoriteOnly = false
    @Published var photoList: [Photo] = []

    @Published var filteredList: [Photo] = []
}

extension PhotoListViewModel {
    func toggleFavorite(_ id: Int?) {
        if let i = allPhotos.firstIndex(where: { $0.id == id }) {
            allPhotos[i].favorite.toggle()
        }
    }
}

extension PhotoListViewModel {

//    struct Input {
//        let ready: AnyPublisher<Bool,Never>
//        let favoriteTapped: AnyPublisher<Void,Never>
//        let searchText: AnyPublisher<String?,Never>
//    }
//
//    struct Output {
//    }
//
//    func transform(input: Input) -> Output {
//
//        input.ready
//            .mapToEvent { !$0 }
//            .throttle(for: .seconds(0.5), scheduler: DispatchQueue.userInitiated, latest: true)
//            .map {
//                //        URLSession.shared.dataTaskPublisher(for: "https://jsonplaceholder.typicode.com/photos".url!)
//                //          .timeout(.seconds(10), scheduler: DispatchQueue.userInitiated)
//                //          .map { $0.data }
//                //          .replaceError(with: Data())
//                //          .replaceEmpty(with: Data())
//                Just((try? Data(contentsOf: Bundle.main.url(forResource: "photos", withExtension: "json")!)) ?? Data())
//                    .delay(for: .seconds(0.5), scheduler: DispatchQueue.userInitiated)
//            }
//            .switchToLatest()
//            .decode(type: [Photo].self, decoder: JSONDecoder())
//            .replaceError(with: [])
//            .receive(on: DispatchQueue.main)
//            .sink { [weak self] in
//                let list = $0.map {
//                    var m = $0
//                    m.url = m.url?.replacingOccurrences(of: "via.placeholder.com", with: "dummyimage.com")
//                    m.thumbnailUrl = m.thumbnailUrl?.replacingOccurrences(of: "via.placeholder.com", with: "dummyimage.com")
//                    return m
//                }
//                self?.allPhotos = list
//            }
//            .store(in: &cancellables)
//
//        input.favoriteTapped
//            .sink { [weak self] in
//                self?.showFavoriteOnly.toggle()
//            }
//            .store(in: &cancellables)
//
//        $allPhotos
//            .dropFirst()
//            .combineLatest($showFavoriteOnly)
//            .sink { [weak self] list, show in
//                if show {
//                    self?.photoList = list.filter { $0.favorite }
//                } else {
//                    self?.photoList = list
//                }
//            }
//            .store(in: &cancellables)
//
//        $allPhotos
//            .dropFirst()
//            .combineLatest(input.searchText)
//            .sink { [weak self] list, text in
//                if let text = text, !text.isEmpty {
//                    let text = text
//                        .lowercased()
//                        .trimmingCharacters(in: .whitespacesAndNewlines)
//                    self?.filteredList = list
//                        .filter {
//                            ($0.title ?? "").lowercased().contains(text)
//                        }
//                } else {
//                    self?.filteredList = list
//                }
//            }
//            .store(in: &cancellables)
//
//        return .init()
//    }

}
