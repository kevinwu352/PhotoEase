//
//  Alert.swift
//  PhotoEase
//
//  Created by Kevin Wu on 3/6/25.
//

import UIKit

extension UIAlertController {
  func addAction(_ title: String?, _ style: UIAlertAction.Style, _ handler: ((UIAlertAction)->Void)?) {
    let action = UIAlertAction(title: title, style: style, handler: handler)
    addAction(action)
  }
}

struct Alert {

  static func confirm(title: String?,
                      message: String?,
                      cancel: String? = nil,
                      confirm: String? = nil,
                      completion: ((Bool)->Void)?
  ) {
    let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
    ac.addAction(cancel ?? "Cancel", .cancel) { _ in
      completion?(false)
    }
    ac.addAction(confirm ?? "Confirm", .destructive) { _ in
      completion?(true)
    }
    (UIApplication.shared.delegate?.window as? UIWindow)?.rootViewController?.present(ac, animated: true, completion: nil)
  }

}
