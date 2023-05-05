//
//  TabButtonView.swift
//  TBox
//
//  Created by 木本瑛介 on 2023/05/03.
//

import SwiftUI

struct TabButtonView: View {
    var image: String
    var title: String
    
    @Binding var selectedTab: String
    
    var animation: Namespace.ID
    
    var body: some View {
        Button(action: {
            withAnimation(.spring()) {
                selectedTab = title
            }
        }) {
            HStack(spacing: 15) {
                Image(self.image)
                    .font(.title2)
                Text(self.title)
                    .fontWeight(.semibold)
            }
            .foregroundColor(selectedTab == title ? Color.blue : .white)
            .padding(.vertical, 12)
            .padding(.horizontal, 20)
            .background(
                ZStack {
                    if selectedTab == title {
                        Color.white.opacity(selectedTab == title ? 1 : 0)
                            .clipShape(CustomCorners(corners: [.topRight, .bottomRight], radius: 12))
                            .matchedGeometryEffect(id: "TAB", in: animation)
                        
                    }
                }
            )
        }
    }
}

