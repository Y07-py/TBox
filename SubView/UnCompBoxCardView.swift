//
//  UnCompBoxCardView.swift
//  TBox
//
//  Created by 木本瑛介 on 2023/05/03.
//

import SwiftUI

struct UnCompBoxCardView: View {
    
    let box: UncompBox
    let screen: CGRect = UIScreen.main.bounds
    
    @State var iscircle: Bool = false
    
    @Binding var boxArray: [UncompBox]
    
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

extension View {
    func dateTransformerToJP(object: Date?) -> String {
        guard let date = object else { return "期限なし" }
        let dateformatter = DateFormatter()
        dateformatter.locale = Locale(identifier: "ja_JP")
        dateformatter.dateStyle = .full
        dateformatter.timeStyle = .short
        dateformatter.dateFormat = "M月dd日 HH時mm分"
        return dateformatter.string(from: date)
    }
}
