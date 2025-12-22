//
//  BaseCutViewController.swift
//  YDCutter
//
//  Created by 潘语笛 on 2025/12/20.
//

import UIKit
public class BaseCutContext {
    private var di: [String: Any] = [:]

    public func register<T>(_ protocolType: T.Type, implementation: Any) {
        let key = String(describing: protocolType)
        di[key] = implementation
    }

    public func resolve<T>(_ protocolType: T.Type) -> T? {
        let key = String(describing: protocolType)
        return di[key] as? T
    }
}

public class BaseCutViewController: UIViewController {
    var context: BaseCutContext?
    
    init(context: BaseCutContext) {
        self.context = context
        super.init(nibName: nil, bundle: nil)
    }
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
