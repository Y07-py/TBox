//
//  EditBoxView.swift
//  TBox
//
//  Created by 木本瑛介 on 2023/05/02.
//

import SwiftUI

struct EditBoxView: View {
    
    @EnvironmentObject var dbHandler: RealmDBHandler
    @StateObject var notification: NotificationHelper = NotificationHelper()
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var selectDate: Date = Date()
    @State var selectedIndex: Int = 0
    @State var pickerIndex: Int = 0
    @State var times: [String] = ["1時間前", "2時間前", "1日前", "2日前", "カスタム"]
    @State var timeanaunce: [String] = ["1時間", "2時間", "１日", "２日", "カスタム"]
    @State var timeString: [String] = ["分", "時間", "日"]
    @State var uuid: UUID = UUID()
    @State var colors: [UIColor] = []
    @State var selectedColor: Int = 0
    @State var selectedTab: Int = 0
    @State var isNewBox: Bool = false
    @State var custometime: Bool = false
    
    @State var time: String = ""
    
    @State var showDatePicker: Bool = false
    
    let uncompBox: UncompBox?
    let startDate: Date?
    
    var titleisValid: Bool {
        return dbHandler.title.isEmpty
    }
    
    var body: some View {
        Form {
            Section(header: Text("タイトル")) {
                TextField("タスクを入力してください", text: $dbHandler.title)
            }
            Section(header: Text("タスク終了日")) {
                VStack {
                    Toggle(isOn: $showDatePicker) {
                        Text("期限を設定する")
                    }
                    if showDatePicker {
                        DatePicker(
                            "終了日",
                            selection: $selectDate,
                            in: (startDate ?? Date())...,
                            displayedComponents: [.hourAndMinute, .date]
                        )
                        .transition(.move(edge: .bottom))
                    }
                }
            }
            Section(header: Text("通知のタイミング")) {
                Picker(selection: $selectedIndex, label: Text("通知")) {
                    ForEach(0 ..< times.count, id: \.self) { id in
                        Text(self.times[id]).tag(self.times[id])
                    }
                }
                .id(self.uuid)
                .onChange(of: selectedIndex) { newValue in
                    if (selectedIndex == 4) {
                        custometime.toggle()
                    }
                    else {
                        custometime = false
                    }
                }
                if custometime {
                    HStack {
                        TextField("", text: $time)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.numberPad)
                        Picker("", selection: $pickerIndex) {
                            ForEach(0 ..< timeString.count, id: \.self) { index in
                                Text(timeString[index] + "前").tag(pickerIndex)
                            }
                        }
                        .pickerStyle(.wheel)
                    }
                }
            }
            Section(header: Text("Boxの色")) {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(0 ..< 7, id: \.self) { index in
                            VStack {
                                Button(action: {
                                    dbHandler.boxcolor = index
                                    withAnimation {
                                        selectedTab = index
                                    }
                                }) {
                                    Circle()
                                        .frame(width: 50, height: 50)
                                        .foregroundColor(Color(BoxColors().outputBoxColor(index: index)))
                                }
                                Circle()
                                    .frame(width: 10, height: 10)
                                    .foregroundColor(selectedTab == index ? Color.gray : Color.clear)
                            }
                        }
                    }
                }
            }
            Button(action: {
                dbHandler.deadline = selectDate
                
                if dbHandler.boxcolor == nil {
                    dbHandler.boxcolor = 0
                }
                
                if !showDatePicker {
                    dbHandler.deadline = nil
                }
                else {
                    dbHandler.isupdate = true
                    dbHandler.istimeanaunce = true
                    dbHandler.selectedIndex = selectedIndex
                    if custometime {
                        dbHandler.anauncenum = Int(time)!
                    }
                    switch selectedIndex {
                    case 0: dbHandler.timeinterval = 60 * 60
                    case 1: dbHandler.timeinterval = 60 * 60 * 2
                    case 2: dbHandler.timeinterval = 60 * 60 * 24
                    case 3: dbHandler.timeinterval = 60 * 60 * 24 * 2
                    case 4:
                        if pickerIndex == 0 {
                            dbHandler.timeinterval = Double(time)! * 60
                        }
                        else if pickerIndex == 1 {
                            dbHandler.timeinterval = Double(time)! * 60 * 60
                        }
                        else if pickerIndex == 2 {
                            dbHandler.timeinterval = Double(time)! * 60 * 60 * 24
                        }
                    default: break
                    }
                    notification.badge += 1
                    notification.sendNotification(date: selectDate,
                                                  type: "time",
                                                  timeInterval: dbHandler.timeinterval,
                                                  title: "お知らせ",
                                                  body: "\(dbHandler.title)の期限まで残り\(timeanaunce[selectedIndex] == "カスタム" ? "\(time + timeString[pickerIndex])" : timeanaunce[selectedIndex])")
                }
                dbHandler.addbox()
                self.presentationMode.wrappedValue.dismiss()
            }) {
                HStack {
                    Spacer()
                    Text(isNewBox ? "変更" : "追加")
                    Spacer()
                }
            }.disabled(self.titleisValid)
        }
        .onAppear {
            guard let availableBox = uncompBox else {
                dbHandler.deInitBox()
                return
            }
            if availableBox.deadline != nil {
                selectDate = availableBox.deadline!
            }
            isNewBox.toggle()
            dbHandler.updateBox = availableBox
            selectedTab = availableBox.boxcolor
            dbHandler.setupInitialBox()
        }
    }
}
