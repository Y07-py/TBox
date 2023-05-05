//
//  HomeView.swift
//  TBox
//
//  Created by 木本瑛介 on 2023/05/02.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var dbHandler: RealmDBHandler
    
    @State var showingDelete: Bool = false
    @State var showingComplete: Bool = false
    @State var istoggle: Bool = false
    @State var boxArray: [UncompBox] = []
    
    let window: CGRect = UIScreen.main.bounds
    
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    ForEach(dbHandler.unCompBoxs) { box in
                        NavigationLink(destination: EditBoxView(
                            selectedIndex: box.selectedIndex,
                            custometime: box.istimeanaunce,
                            time: String(box.anauncenum),
                            showDatePicker: box.isupdate,
                            uncompBox: box,
                            startDate: box.deadline)) {
                            UnCompBoxCardView(box: box, boxArray: $boxArray)
                                .cornerRadius(15)
                                .contentShape(RoundedRectangle(cornerRadius: 10))
                                .shadow(color: .gray, radius: 10, x: 5, y: 5)
                                .padding()
                        }
                    }
                }
            }
            .padding()
            .offset(y: window.height / 20)
            .frame(height: window.height - 150)
            HStack(spacing: (window.width - 100) / 3) {
                Button(action: {
                    showingDelete.toggle()
                }) {
                    Image("trash")
                        .resizable()
                        .aspectRatio(contentMode:.fill)
                        .frame(width: 60, height: 60)
                }
                .alert(isPresented: $showingDelete) {
                    Alert(title: Text(""),
                          message: Text("選択したBoxを消去しますか？"),
                          primaryButton: .default(Text("いいえ")),
                          secondaryButton: .default(Text("はい"), action: {
                        dbHandler.deleteUncompBoxs = boxArray
                        for box in boxArray {
                            dbHandler.unCompBoxs.removeAll { $0.id == box.id }
                        }
                        boxArray.removeAll()
                        dbHandler.deleteUncompBpx()
                    }))
                }
                Button(action: {
                    showingComplete.toggle()
                    istoggle.toggle()
                }) {
                    Image("checkbox")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 60, height: 60)
                }
                .alert(isPresented: $showingComplete) {
                    Alert(title: Text(""),
                          message: Text("選択したBoxを完了しますか?"),
                          primaryButton: .default(Text("いいえ")),
                          secondaryButton: .default(Text("はい"), action: {
                        dbHandler.checkUncompBox = boxArray
                        dbHandler.deleteUncompBoxs = boxArray
                        for box in boxArray {
                            dbHandler.unCompBoxs.removeAll { $0.id == box.id }
                        }
                        boxArray.removeAll()
                        dbHandler.addCompBox()
                        dbHandler.deleteUncompBpx()
                    })
                    )
                }
                NavigationLink(destination: EditBoxView(uncompBox: nil, startDate: nil)) {
                    Image("pen")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 60, height: 60)
                }
            }.padding()
                .offset(y: 10)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(RealmDBHandler())
    }
}
