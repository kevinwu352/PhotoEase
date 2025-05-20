//
//  RootViewController.swift
//  PhotoEase
//
//  Created by Kevin Wu on 3/5/25.
//

import UIKit

class RootViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    title = "Photos App"

    view.addSubview(photoBtn)
  }
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    photoBtn.sizeToFit()
    photoBtn.center = view.center
  }

  lazy var photoBtn: UIButton = {
    var config = UIButton.Configuration.plain()
    config.title = "Photos"
    let ret = UIButton(configuration: config)
    ret.addTarget(self, action: #selector(photoClicked), for: .touchUpInside)
    return ret
  }()
  @objc func photoClicked() {
    let vc = PhotoListViewController()
    vc.hidesBottomBarWhenPushed = true
    navigationController?.pushViewController(vc, animated: true)
  }

}
