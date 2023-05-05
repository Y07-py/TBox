//
//  FailedBoxView.swift
//  TBox
//
//  Created by 木本瑛介 on 2023/05/03.
//

import SwiftUI

struct FailedBoxView: View {
    
    @EnvironmentObject var dbHandler: RealmDBHandler
    
    @State var boxArray: [FailedBox] = []
    @State var showingDelete: Bool = false
    
    let window: CGRect = UIScreen.main.bounds
    
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    ForEach(dbHandler.failedBoxs) { box in
                        FailedBoxCardView(box: box, boxArray: $boxArray)
                            .cornerRadius(15)
                            .contentShape(RoundedRectangle(cornerRadius: 10))
                            .shadow(color: .gray, radius: 10, x: 5, y: 5)
                            .padding()
                    }
                }
            }
            .padding()
            .offset(y: window.height / 20)
            .frame(height: window.height - 150)
            HStack(spacing: window.height - 100) {
                Button(action: {
                    self.showingDelete.toggle()
                }) {
                    Image("trash")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 60, height: 60)
                }
                .alert(isPresented: $showingDelete) {
                    Alert(title: Text(""),
                          message: Text("選択したBoxを消去しますか?"),
                          primaryButton: .default(Text("いいえ")),
                          secondaryButton: .default(Text("はい"), action: {
                        dbHandler.deleteFailedBoxs = boxArray
                        for box in boxArray {
                            dbHandler.failedBoxs.removeAll { $0.id == box.id }
                        }
                        boxArray.removeAll()
                        dbHandler.deleteFailedBox()
                    }))
                }
                
            }
            .padding()
            .offset(y: 10)
        }
    }
}

struct FailedBoxView_Previews: PreviewProvider {
    static var previews: some View {
        FailedBoxView()
            .environmentObject(RealmDBHandler())
    }
}
