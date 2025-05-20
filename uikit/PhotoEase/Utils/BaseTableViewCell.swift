//
//  BaseTableViewCell.swift
//  PhotoEase
//
//  Created by Kevin Wu on 3/6/25.
//

import UIKit
import Combine

class BaseTableViewCell: UITableViewCell {

  override class var requiresConstraintBasedLayout: Bool { true }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  override func awakeFromNib() {
    super.awakeFromNib()
    setup()
    layoutViews()
    bindEvents()
  }
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setup()
    layoutViews()
    bindEvents()
  }
  override func updateConstraints() {
    layoutViews()
    super.updateConstraints()
  }

  func setup() {
  }
  func layoutViews() {
  }
  func bindEvents() {
  }


  lazy var cancellables = Set<AnyCancellable>()
}


extension UITableViewCell {
  static var reuseId: String {
    String(describing: self)
  }
}
