//
//  BaseCutViewModel.swift
//  YDCutter
//
//  Created by 潘语笛 on 2025/12/23.
//

import UIKit
import Combine

public class BaseCutViewModel: NSObject {
    var context: BaseCutContext
    required init(context: BaseCutContext) {
        self.context = context
    }
    // 公开的state publisher，只读
    public var statePublisher: AnyPublisher<CutState, Never>? {
        return context.statePublisher
    }
    public func updateState(newState: CutState) {
        context.updateState(newState)
    }
}
