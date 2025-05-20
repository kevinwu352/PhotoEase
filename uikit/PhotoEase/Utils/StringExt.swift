//
//  StringExt.swift
//  PhotoEase
//
//  Created by Kevin Wu on 3/6/25.
//

import UIKit

public extension String {
  var url: URL? {
    URL(string: self)
  }
}
