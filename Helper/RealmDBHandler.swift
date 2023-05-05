//
//  RealmDBHandler.swift
//  TBox
//
//  Created by 木本瑛介 on 2023/05/03.
//

import Foundation
import SwiftUI
import RealmSwift

class RealmDBHandler: ObservableObject {
    
    @Published var title: String = ""
    @Published var content: String = ""
    @Published var deadline: Date?
    @Published var anauncetime: Date?
    @Published var boxcolor: Int?
    @Published var updateBox: UncompBox?
    @Published var timeinterval: Double = 0
    @Published var isupdate: Bool = false
    @Published var istimeanaunce: Bool = false
    @Published var anauncenum: Int = 0
    @Published var selectedIndex: Int = 0
    
    @Published var unCompBoxs: [UncompBox] = []
    @Published var deleteUncompBoxs: [UncompBox] = []
    @Published var checkUncompBox: [UncompBox] = []
    
    @Published var compBoxs: [CompBox] = []
    @Published var deleteCompBoxs: [CompBox] = []
    
    @Published var failedBoxs: [FailedBox] = []
    @Published var deleteFailedBoxs: [FailedBox] = []
    
    init() {
        
        let config = Realm.Configuration(schemaVersion: 7)
        Realm.Configuration.defaultConfiguration = config
        fetchUncompBox()
        fetchCompBox()
        fetchFailedBox()
        
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) {
            timer in
            let currentDate = Date()
            let cal = Calendar(identifier: .gregorian)
            for box in self.unCompBoxs {
                guard let boxdeadline = box.deadline else { return }
                let diff = cal.dateComponents([.second], from: boxdeadline, to: currentDate)
                guard let diff = diff.second else { return }
                if (diff <= 1 && 0 <= diff) {
                    self.unCompBoxs.removeAll { $0.id == box.id }
                    self.addFailedBox(object: box)
                    self.deleteOneUncompBox(object: box)
                }
            }
            self.fetchFailedBox()
        }
    }
    
    func addbox() {
        if title == "" { return }
        
        let box = UncompBox()
        box.title = title
        box.cotent = content
        box.deadline = deadline
        box.anauncetime = anauncetime
        box.boxcolor = boxcolor!
        box.isupdate = isupdate
        box.istimeanaunce = istimeanaunce
        box.anauncenum = anauncenum
        box.selectedIndex = selectedIndex
        
        
        guard let dbRef = try? Realm() else { return }
        try? dbRef.write({
            guard let availableBox = updateBox else {
                dbRef.add(box)
                fetchUncompBox()
                return
            }
            availableBox.title = title
            availableBox.cotent = content
            availableBox.boxcolor = boxcolor!
            availableBox.deadline = deadline
            availableBox.anauncetime = anauncetime
            availableBox.isupdate = isupdate
            availableBox.istimeanaunce = istimeanaunce
            availableBox.anauncenum = anauncenum
            availableBox.selectedIndex = selectedIndex
        })
        fetchUncompBox()
        print(unCompBoxs)
    }
    
    func addCompBox() {
        guard let dbRef = try? Realm() else { return }
        for box in checkUncompBox {
            Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { [self] time in
                let compBox = CompBox()
                compBox.title = box.title
                compBox.content = box.cotent
                compBox.deadline = box.deadline
                compBox.anauncetime = box.anauncetime
                compBox.boxcolor = box.boxcolor
                try? dbRef.write({
                    dbRef.add(compBox)
                    print(compBox)
                    fetchCompBox()
                })
            }
        }
    }
    
    func addFailedBox(object: UncompBox) {
        let failedBox = FailedBox()
        failedBox.title = object.title
        failedBox.content = object.cotent
        failedBox.deadline = object.deadline
        failedBox.anaunce = object.anauncetime
        failedBox.boxcolor = object.boxcolor
        
        guard let dbRef = try? Realm() else { return }
        try? dbRef.write({
            dbRef.add(failedBox)
            fetchFailedBox()
        })
    }
    
    func fetchUncompBox() {
        guard let dbRef = try? Realm() else { return }
        let results = dbRef.objects(UncompBox.self)
        self.unCompBoxs = results.compactMap({ (box) in
            return box
        })
    }
    
    func fetchCompBox() {
        guard let dbRef = try? Realm() else { return }
        let results = dbRef.objects(CompBox.self)
        self.compBoxs = results.compactMap({ (box) in
            return box
        })
    }
    
    func fetchFailedBox() {
        guard let dbRef = try? Realm() else { return }
        let results = dbRef.objects(FailedBox.self)
        self.failedBoxs = results.compactMap({ (box) in
            return box
        })
    }
    
    func deleteUncompBpx() {
        guard let dbRef = try? Realm() else { return }
        for box in deleteUncompBoxs {
            Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { [self] timer in
                try? dbRef.write({
                    dbRef.delete(box)
                    fetchUncompBox()
                })
            }
        }
    }
    
    func deleteOneUncompBox(object: UncompBox) {
        guard let dbRef = try? Realm() else { return }
        try? dbRef.write({
            dbRef.delete(object)
            self.fetchUncompBox()
        })
    }
    
    func deleteCompBox() {
        guard let dbRef = try? Realm() else { return }
        for box in deleteCompBoxs {
            Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { [self] timer in
                try? dbRef.write({
                    dbRef.delete(box)
                    fetchCompBox()
                })
            }
        }
    }
    
    func deleteFailedBox() {
        guard let dbRef = try? Realm() else { return }
        for box in deleteFailedBoxs {
            Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { [self] timer in
                try? dbRef.write({
                    dbRef.delete(box)
                    fetchFailedBox()
                })
            }
        }
    }
    
    func setupInitialBox() {
        guard let availableBox = updateBox else { return }
        title = availableBox.title
        anauncetime = availableBox.anauncetime
        deadline = availableBox.deadline
        boxcolor = availableBox.boxcolor
    }
    
    func deInitBox() {
        updateBox = nil
        title = ""
        deadline = Date()
        boxcolor = 0
    }
    
}
