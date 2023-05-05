//
//  CompBoxCardView.swift
//  TBox
//
//  Created by 木本瑛介 on 2023/05/03.
//

import SwiftUI

struct CompBoxCardView: View {
    
    let box: CompBox
    let screen: CGRect = UIScreen.main.bounds
    
    @State var iscircle: Bool = false
    
    @Binding var boxArray: [CompBox]
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    self.iscircle.toggle()
                    boxArray.append(box)
                }) {
                    ZStack {
                        Circle()
                            .foregroundColor(Color.white)
                            .frame(width: 20, height: 20)
                        Circle()
                            .foregroundColor(iscircle ? Color.green : Color.white)
                            .frame(width: 15, height: 15)
                    }
                }
                .offset(x: 15)
                VStack(spacing: 5) {
                    HStack {
                        Spacer()
                        Text(box.title)
                            .lineLimit(1)
                            .font(.title2)
                            .foregroundColor(Color.black)
                        Spacer()
                    }
                    .offset(y: 15)
                    Text(dateTransformerToJP(object: box.deadline))
                        .frame(width: 300)
                        .font(.title3)
                        .padding()
                        .foregroundColor(Color.black)
                }
            }
        }
        .frame(width: screen.width - 30, height: 70)
        .background(Color(BoxColors().outputBoxColor(index: box.boxcolor)))
    }
}

