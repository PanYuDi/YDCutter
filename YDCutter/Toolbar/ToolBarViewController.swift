//
//  ToolBarViewController.swift
//  YDCutter
//
//  Created by 潘语笛 on 2025/12/17.
//

import UIKit
import SnapKit

class ToolBarViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(white: 0.2, alpha: 1.0)
        
        // Add a label for identification
        let label = UILabel()
        label.text = "Toolbar Area"
        label.textColor = .white
        view.addSubview(label)
        
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
