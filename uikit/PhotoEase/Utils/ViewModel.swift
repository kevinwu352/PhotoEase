//
//  ViewModel.swift
//  PhotoEase
//
//  Created by Kevin Wu on 3/5/25.
//

import UIKit

protocol ViewModel {
  associatedtype Input
  associatedtype Output

  func transform(input: Input) -> Output
}
