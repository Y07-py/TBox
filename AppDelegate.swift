//
//  AppDelegate.swift
//  TBox
//
//  Created by 木本瑛介 on 2023/05/03.
//

import Foundation
import SwiftUI

class AppDelegate: UIResponder, UIApplicationDelegate {
    let notification: NotificationHelper = NotificationHelper()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        notification.askPermission()
        return true
    }
}
