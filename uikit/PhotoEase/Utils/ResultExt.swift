//
//  ResultExt.swift
//  PhotoEase
//
//  Created by Kevin Wu on 3/6/25.
//

import UIKit

public extension Result {
  var isSuccess: Bool {
    if case .success = self { return true } else { return false }
  }
  var isFailure: Bool {
    if case .failure = self { return true } else { return false }
  }
}
