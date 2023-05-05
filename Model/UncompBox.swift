//
//  UncompBox.swift
//  TBox
//
//  Created by 木本瑛介 on 2023/05/02.
//

import Foundation
import SwiftUI
import RealmSwift
import Combine


class UncompBox: Object, Identifiable {
    @objc dynamic var id: UUID = UUID()
    @objc dynamic var title: String = ""
    @objc dynamic var cotent: String = ""
    @objc dynamic var deadline: Date?
    @objc dynamic var anauncetime: Date?
    @objc dynamic var boxcolor: Int = 0
    @objc dynamic var timeinterval: Double = 0
    @objc dynamic var isupdate: Bool = false
    @objc dynamic var istimeanaunce: Bool = false
    @objc dynamic var anauncenum: Int = 0
    @objc dynamic var selectedIndex: Int = 0
}
