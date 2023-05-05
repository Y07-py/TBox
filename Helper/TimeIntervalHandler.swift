//
//  TimeIntervalHandler.swift
//  TBox
//
//  Created by 木本瑛介 on 2023/05/04.
//

import Foundation
import Combine

class TimeIntervalHandler: ObservableObject {
    private var canncellablePipeline: AnyCancellable?
    
    init() {
        canncellablePipeline = Timer
            .publish(every: 1.0, on: .main, in: .common)
            .autoconnect()
            .sink(receiveValue: { [unowned self] _ in
                print("Hello")
            })
    }
}
