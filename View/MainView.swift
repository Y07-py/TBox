//
//  MainView.swift
//  TBox
//
//  Created by 木本瑛介 on 2023/05/03.
//

import SwiftUI

struct MainView: View {
    @Binding var selectedTab: String
    
    init(selectedTab: Binding<String>) {
        self._selectedTab = selectedTab
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView().tag("Task")
            CompletedBoxView().tag("Comp")
            FailedBoxView().tag("Failed")
            HelpView().tag("Help")
        }
    }
}

