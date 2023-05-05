//
//  MenuView.swift
//  TBox
//
//  Created by 木本瑛介 on 2023/05/03.
//

import SwiftUI

struct MenuView: View {
    @State var selectedTab: String = "Task"
    @State var showMenu: Bool = false
    @Namespace var animation
    
    var body: some View {
        ZStack {
            Color(red: 0.13, green: 0.89, blue: 0.68).ignoresSafeArea()
            VStack(alignment: .leading, spacing: 15) {
                VStack(spacing: 10) {
                    TabButtonView(image: "list", title: "Task", selectedTab: $selectedTab,
                        animation: animation)
                    TabButtonView(image: "completed", title: "Comp", selectedTab: $selectedTab,
                        animation: animation)
                    TabButtonView(image: "failed", title: "Failed", selectedTab: $selectedTab,
                        animation:animation)
                    TabButtonView(image: "help", title: "Help", selectedTab: $selectedTab,
                        animation: animation)
                    
                }.padding(.leading, -15)
                
                    .padding(.top, 50)
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            ZStack {
                Color.white
                    .opacity(0.5)
                    .cornerRadius(showMenu ? 15 : 0)
                    .shadow(color: Color.black.opacity(0.07), radius: 5, x: -5, y: 0)
                    .offset(x: showMenu ? -25 : 0)
                    .padding(.vertical, 30)
                Color.white
                    .opacity(0.5)
                    .cornerRadius(showMenu ? 15 : 0)
                    .shadow(color: Color.black.opacity(0.07), radius: 5, x: -5, y: 0)
                    .offset(x: showMenu ? -50 : 0)
                    .padding(.vertical, 60)
                MainView(selectedTab: $selectedTab)
                    .cornerRadius(showMenu ? 15 : 0)
            }
            .scaleEffect(showMenu ? 0.84: 1)
            .offset(x: showMenu ?  getRect().width - 120: 0)
            .ignoresSafeArea()
            .overlay(
                Button(action: {
                    withAnimation(.spring()) {
                        showMenu.toggle()}
                    }) {
                        VStack(spacing: 5) {
                            Capsule()
                                .fill(showMenu ? Color.white : Color.primary)
                                .frame(width: 30, height: 3)
                                .rotationEffect(.init(degrees: showMenu ? -50: 0))
                                .offset(x: showMenu ? 2 : 0, y: showMenu ? 9 : 0)
                            VStack(spacing: 5) {
                                Capsule()
                                    .fill(showMenu ? Color.white : Color.primary)
                                    .frame(width: 30, height: 3)
                                Capsule()
                                    .fill(showMenu ? Color.white : Color.primary)
                                    .frame(width: 30, height: 3)
                                    .offset(y: showMenu ? -8 : 0)
                                
                            }
                            .rotationEffect(.init(degrees: showMenu ? 50 : 0))
                        }
                    }
                        .padding()
                    ,alignment: .topLeading
                )
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}

extension View {
    func getRect() -> CGRect {
        return UIScreen.main.bounds
    }
}
