//
//  BaseCutContext.swift
//  YDCutter
//
//  Created by 潘语笛 on 2025/12/23.
//

import UIKit
import Combine

public struct CutState {
    var url: URL?
}

public class BaseCutContext: NSObject {
    private var di: [String: Any] = [:]
    
    // MARK: - State Publisher
    @Published private var publishedState: CutState = CutState()
    
    // 公开的state publisher，只读
    public var statePublisher: AnyPublisher<CutState, Never> {
        $publishedState.eraseToAnyPublisher()
    }
    
    // 获取当前状态
    public var currentState: CutState {
        return publishedState
    }
    
    // 更新状态的方法
    public func updateState(_ newState: CutState) {
        publishedState = newState
    }
    
    // 部分更新状态的方法
    public func updateState(_ transform: (inout CutState) -> Void) {
        var newState = publishedState
        transform(&newState)
        publishedState = newState
    }
    

    public func register<T>(_ protocolType: T.Type, implementation: Any) {
        let key = String(describing: protocolType)
        di[key] = implementation
    }

    public func resolve<T>(_ protocolType: T.Type) -> T? {
        let key = String(describing: protocolType)
        return di[key] as? T
    }
}
