//
//  TBoxApp.swift
//  TBox
//
//  Created by 木本瑛介 on 2023/05/02.
//

import SwiftUI

@main
struct TBoxApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    @StateObject private var dbHandler: RealmDBHandler = RealmDBHandler()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(dbHandler)
        }
    }
}
