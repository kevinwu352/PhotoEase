//
//  CombineExt.swift
//  PhotoEase
//
//  Created by Kevin Wu on 3/6/25.
//

import UIKit
import Combine

public extension Publisher where Failure == Never {
  func mapToEvent(_ h: @escaping (Output)->Bool) -> AnyPublisher<Void,Never> {
    filter(h)
      .map { _ in () }
      .eraseToAnyPublisher()
  }
}
