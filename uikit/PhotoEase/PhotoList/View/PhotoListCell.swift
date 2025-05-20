//
//  PhotoListCell.swift
//  PhotoEase
//
//  Created by Kevin Wu on 3/6/25.
//

import UIKit
import Kingfisher

class PhotoListCell: BaseTableViewCell {

  override func setup() {
    super.setup()
    selectionStyle = .none
    separatorInset = .init(top: 0, left: 80, bottom: 0, right: 0)
    accessoryType = .disclosureIndicator

    contentView.addSubview(iconView)
    contentView.addSubview(titleLabel)
    contentView.addSubview(favoriteBtn)
  }
  override func layoutViews() {
    super.layoutViews()
    iconView.snp.remakeConstraints { make in
      make.leading.equalToSuperview().offset(20)
      make.centerY.equalToSuperview()
      make.size.equalTo(CGSize(width: 50, height: 50))
    }
    favoriteBtn.snp.remakeConstraints { make in
      make.trailing.equalToSuperview().offset(-10)
      make.centerY.equalToSuperview()
    }
    titleLabel.snp.remakeConstraints { make in
      make.centerY.equalToSuperview()
      make.leading.equalTo(iconView.snp.trailing).offset(10)
      make.trailing.equalTo(favoriteBtn.snp.leading).offset(-10)
    }
  }


  var imageUrl: String?
  func loadImage() {
    let processor = RoundCornerImageProcessor(radius: .widthFraction(0.5),
                                              targetSize: CGSize(width: 50, height: 50))
    iconView.kf.setImage(with: imageUrl?.url,
                         placeholder: nil,
                         options: [
                          .processor(processor),
                          .backgroundDecode,
                          .cacheOriginalImage,
                         ]) { [weak self] res in
                           self?.iconView.isHidden = res.isFailure
                         }
  }

  var title: String? {
    get { titleLabel.text }
    set { titleLabel.text = newValue }
  }

  var favorite: Bool {
    get { favoriteBtn.isSelected }
    set { favoriteBtn.isSelected = newValue }
  }

  var photoId: Int?
  weak var delegate: (any PhotoListDelegate)?
  @objc func favoriteClicked() {
    delegate?.favoriteDidChange(photoId)
  }


  override func prepareForReuse() {
    super.prepareForReuse()
    iconView.kf.cancelDownloadTask()
    iconView.image = nil
    iconView.isHidden = true
  }


  lazy var iconView: UIImageView = {
    let ret = UIImageView()
    ret.isHidden = true
    ret.layer.shadowColor = UIColor.black.cgColor
    ret.layer.shadowRadius = 3.0
    ret.layer.shadowOpacity = 1.0
    ret.layer.shadowPath = UIBezierPath(ovalIn: CGRect(x: 0, y: 3, width: 50, height: 50)).cgPath
    return ret
  }()

  lazy var titleLabel: UILabel = {
    let ret = UILabel()
    ret.font = .systemFont(ofSize: 16)
    ret.textColor = .black
    ret.numberOfLines = 2
    ret.setContentHuggingPriority(.defaultLow-1, for: .horizontal)
    ret.setContentCompressionResistancePriority(.defaultHigh-1, for: .horizontal)
    return ret
  }()

  lazy var favoriteBtn: UIButton = {
    let ret = UIButton(type: .custom)
    ret.tintColor = .black
    ret.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 18), forImageIn: .normal)
    ret.setImage(UIImage(systemName: "star"), for: .normal)
    ret.setImage(UIImage(systemName: "star.fill"), for: .selected)
    ret.addTarget(self, action: #selector(favoriteClicked), for: .touchUpInside)
    return ret
  }()

}
