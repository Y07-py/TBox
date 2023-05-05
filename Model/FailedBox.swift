//
//  FailedBox.swift
//  TBox
//
//  Created by 木本瑛介 on 2023/05/03.
//

import Foundation
import SwiftUI
import RealmSwift

class FailedBox: Object, Identifiable {
    @objc dynamic var id: UUID = UUID()
    @objc dynamic var title: String = ""
    @objc dynamic var content: String = ""
    @objc dynamic var deadline: Date?
    @objc dynamic var anaunce: Date?
    @objc dynamic var boxcolor: Int = 0
}

