//
//  TimelineViewController.swift
//  YDCutter
//
//  Created by 潘语笛 on 2025/12/17.
//

import UIKit
import SnapKit

class TimelineViewController: BaseCutViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkGray
        
        // Add a label for identification
        let label = UILabel()
        label.text = "Timeline Area"
        label.textColor = .white
        view.addSubview(label)
        
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }

}
