//
//  BaseViewController.swift
//  PhotoEase
//
//  Created by Kevin Wu on 3/5/25.
//

import UIKit
import Combine

class BaseViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
    layoutViews()
    bindEvents()
  }
  override func updateViewConstraints() {
    layoutViews()
    super.updateViewConstraints()
  }

  func setup() {
  }
  func layoutViews() {
  }
  func bindEvents() {
  }


  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    viewDidAppearPub.send(viewAppearedEver)
  }
  lazy var viewDidAppearPub = PassthroughSubject<Bool,Never>()

  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    setAppearedEver()
  }
  var viewAppearedEver = false
  func setAppearedEver() {
    guard !viewAppearedEver else { return }
    NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(appearedEver), object: nil)
    perform(#selector(appearedEver), with: nil, afterDelay: 0)
  }
  @objc func appearedEver() {
    viewAppearedEver = true
  }


  lazy var cancellables = Set<AnyCancellable>()
}
