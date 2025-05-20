//
//  PhotoSearchResultViewController.swift
//  PhotoEase
//
//  Created by Kevin Wu on 3/6/25.
//

import UIKit

class PhotoSearchResultViewController: UITableViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.showsHorizontalScrollIndicator = false
    tableView.register(PhotoListCell.self, forCellReuseIdentifier: PhotoListCell.reuseId)
    tableView.rowHeight = 80
  }

  var list: [Photo] = [] {
    didSet {
      guard isViewLoaded else { return }
      tableView.reloadData()
      loadImageForVisibleCells()
    }
  }

  weak var delegate: (any PhotoListDelegate)?

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    list.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: PhotoListCell.reuseId, for: indexPath) as! PhotoListCell

    let model = list[indexPath.row]

    cell.imageUrl = model.thumbnailUrl
    cell.title = model.title
    cell.favorite = model.favorite

    cell.photoId = model.id
    cell.delegate = delegate

    return cell
  }

  override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    guard !decelerate else { return }
    loadImageForVisibleCells()
  }
  override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    loadImageForVisibleCells()
  }
  override func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
    loadImageForVisibleCells()
  }

  func loadImageForVisibleCells() {
    tableView.visibleCells.forEach {
      ($0 as? PhotoListCell)?.loadImage()
    }
  }

}
