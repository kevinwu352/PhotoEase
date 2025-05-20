//
//  PhotoDetailViewController.swift
//  PhotoEase
//
//  Created by Kevin Wu on 3/5/25.
//

import UIKit
import Kingfisher

class PhotoDetailViewController: BaseViewController {

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  init(photo: Photo) {
    self.photo = photo
    super.init(nibName: nil, bundle: nil)
  }

  var photo: Photo {
    didSet { favoriteBtn.isSelected = photo.favorite }
  }

  weak var delegate: (any PhotoListDelegate)?


  override func setup() {
    super.setup()
    view.backgroundColor = .white
    title = "Photo Detail"

    navigationItem.rightBarButtonItem = UIBarButtonItem(customView: favoriteBtn)
    favoriteBtn.isSelected = photo.favorite

    view.addSubview(imageView)
    loadImage()

    view.addSubview(titleLabel)
    titleLabel.text = "Title: " + (photo.title ?? "")
  }
  override func layoutViews() {
    super.layoutViews()
    imageView.snp.remakeConstraints { make in
      make.leading.trailing.equalToSuperview().inset(40)
      make.top.equalTo(view.safeAreaLayoutGuide).offset(40)
      make.height.equalTo(imageView.snp.width)
    }

    titleLabel.snp.remakeConstraints { make in
      make.top.equalTo(imageView.snp.bottom).offset(100)
      make.leading.trailing.equalToSuperview().inset(40)
    }
  }


  @objc func favoriteClicked() {
    if photo.favorite {
      Alert.confirm(title: "Are you sure to dislike this photo?",
                    message: nil,
                    confirm: "Sure") { [weak self] res in
        guard res else { return }
        self?.toggleFavorite()
      }
    } else {
      toggleFavorite()
    }
  }
  func toggleFavorite() {
    delegate?.favoriteDidChange(photo.id)
    photo.favorite.toggle()
  }

  func loadImage() {
    imageView.kf.setImage(with: photo.url?.url,
                          placeholder: nil,
                          options: [
                            .backgroundDecode,
                            .cacheOriginalImage,
                            .transition(.fade(0.25))
                          ])
  }


  lazy var favoriteBtn: UIButton = {
    let ret = UIButton(type: .custom)
    ret.tintColor = .systemBlue
    ret.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 18), forImageIn: .normal)
    ret.setImage(UIImage(systemName: "star"), for: .normal)
    ret.setImage(UIImage(systemName: "star.fill"), for: .selected)
    ret.addTarget(self, action: #selector(favoriteClicked), for: .touchUpInside)
    return ret
  }()

  lazy var imageView: UIImageView = {
    let ret = UIImageView()
    return ret
  }()

  lazy var titleLabel: UILabel = {
    let ret = UILabel()
    ret.font = .systemFont(ofSize: 16)
    ret.textColor = .black
    ret.textAlignment = .center
    ret.numberOfLines = 0
    return ret
  }()

}
