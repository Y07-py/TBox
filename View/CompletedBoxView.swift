//
//  CompletedBoxView.swift
//  TBox
//
//  Created by 木本瑛介 on 2023/05/03.
//

import SwiftUI

struct CompletedBoxView: View {
    
    @EnvironmentObject var dbHandler: RealmDBHandler
    
    @State var boxArray: [CompBox] = []
    @State var showingDelete: Bool = false
    
    let screen: CGRect = UIScreen.main.bounds
    
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    ForEach(dbHandler.compBoxs) { box in
                        CompBoxCardView(box: box, boxArray: $boxArray)
                            .cornerRadius(15)
                            .contentShape(RoundedRectangle(cornerRadius: 10))
                            .shadow(color: .gray, radius: 10, x: 5, y: 5)
                            .padding()
                    }
                }
            }
            .padding()
            .offset(y: screen.height / 20)
            .frame(height: screen.height - 150)
            HStack(spacing: screen.width - 100) {
                Button(action: {
                    showingDelete.toggle()
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
                        dbHandler.deleteCompBoxs = boxArray
                        for box in boxArray {
                            dbHandler.compBoxs.removeAll { $0.id == box.id }
                        }
                        boxArray.removeAll()
                        dbHandler.deleteCompBox()
                    }))
                }
            }
            .padding()
            .offset(y: 10)
        }
    }
}

struct CompletedBoxView_Previews: PreviewProvider {
    static var previews: some View {
        CompletedBoxView()
            .environmentObject(RealmDBHandler())
    }
}
