//
//  BaseCutViewController.swift
//  YDCutter
//
//  Created by 潘语笛 on 2025/12/20.
//

import UIKit


public class BaseCutViewController<T: BaseCutViewModel>: UIViewController {
    var context: BaseCutContext
    var viewModel: T
    
    required init(context: BaseCutContext) {
        self.context = context
        self.viewModel = T(context: context)
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
