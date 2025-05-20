//
//  AppDelegate.swift
//  PhotoEase
//
//  Created by Kevin Wu on 3/5/25.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

    window = UIWindow(frame: UIScreen.main.bounds)
    let nav = UINavigationController(rootViewController: RootViewController())
    nav.navigationBar.prefersLargeTitles = true
    window?.rootViewController = nav
    window?.makeKeyAndVisible()

    return true
  }

}
