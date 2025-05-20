//
//  PhotoListViewController.swift
//  PhotoEase
//
//  Created by Kevin Wu on 3/5/25.
//

import UIKit
import SnapKit

class PhotoListViewController: BaseViewController {

  override func setup() {
    super.setup()
    view.backgroundColor = .white
    title = "Photo List"

    navigationItem.searchController = searchVc
    navigationItem.hidesSearchBarWhenScrolling = false
    navigationItem.rightBarButtonItem = UIBarButtonItem(customView: favoriteBtn)

    view.addSubview(tableView)
  }
  override func layoutViews() {
    super.layoutViews()
    tableView.snp.remakeConstraints { make in
      make.edges.equalToSuperview()
    }
  }

  override func bindEvents() {
    super.bindEvents()
    _ = vm.transform(input: .init(
      ready: viewDidAppearPub.eraseToAnyPublisher(),
      favoriteTapped: favoriteBtn.cmb.tap,
      searchText: searchVc.searchBar.searchTextField.cmb.text
    ))

    vm.$showFavoriteOnly
      .assign(to: \.isSelected, on: favoriteBtn)
      .store(in: &cancellables)

    vm.$photoList
      .dropFirst()
      .sink { [weak self] _ in
        self?.tableView.reloadData()
        self?.loadImageForVisibleCells()
      }
      .store(in: &cancellables)

    vm.$filteredList
      .dropFirst()
      .assign(to: \.list, on: resultVc)
      .store(in: &cancellables)
  }


  lazy var vm = PhotoListViewModel()

  lazy var tableView: UITableView = {
    let ret = UITableView(frame: UIScreen.main.bounds, style: .plain)
    ret.showsHorizontalScrollIndicator = false
    ret.dataSource = self
    ret.delegate = self
    ret.register(PhotoListCell.self, forCellReuseIdentifier: PhotoListCell.reuseId)
    ret.rowHeight = 80
    return ret
  }()

  lazy var searchVc: UISearchController = {
    let ret = UISearchController(searchResultsController: resultVc)
    ret.searchBar.spellCheckingType = .no
    ret.searchBar.autocorrectionType = .no
    ret.searchBar.autocapitalizationType = .none
    return ret
  }()

  lazy var resultVc: PhotoSearchResultViewController = {
    let ret = PhotoSearchResultViewController()
    ret.delegate = self
    return ret
  }()

  lazy var favoriteBtn: UIButton = {
    let ret = UIButton(type: .custom)
    ret.tintColor = .systemBlue
    ret.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 18), forImageIn: .normal)
    ret.setImage(UIImage(systemName: "star"), for: .normal)
    ret.setImage(UIImage(systemName: "star.fill"), for: .selected)
    return ret
  }()

}

extension PhotoListViewController: UITableViewDataSource, UITableViewDelegate {

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    vm.photoList.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: PhotoListCell.reuseId, for: indexPath) as! PhotoListCell

    let model = vm.photoList[indexPath.row]

    cell.imageUrl = model.thumbnailUrl
    cell.title = model.title
    cell.favorite = model.favorite

    cell.photoId = model.id
    cell.delegate = self

    return cell
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let vc = PhotoDetailViewController(photo: vm.photoList[indexPath.row])
    vc.delegate = self
    navigationController?.pushViewController(vc, animated: true)
  }

  func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    guard !decelerate else { return }
    loadImageForVisibleCells()
  }
  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    loadImageForVisibleCells()
  }
  func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
    loadImageForVisibleCells()
  }

  func loadImageForVisibleCells() {
    tableView.visibleCells.forEach {
      ($0 as? PhotoListCell)?.loadImage()
    }
  }

}

extension PhotoListViewController: PhotoListDelegate {

  func favoriteDidChange(_ id: Int?) {
    vm.toggleFavorite(id)
  }

}
