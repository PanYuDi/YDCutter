//
//  PreviewViewController.swift
//  YDCutter
//
//  Created by 潘语笛 on 2025/12/17.
//

import UIKit
import SnapKit
import AVFoundation

public protocol PreviewViewControllerProtocol {
    func setupPlayer(url: URL)
}

class PreviewViewController: BaseCutViewController {
    var player: AVPlayer? = nil
    var previewLayer: AVPlayerLayer? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupUI()

    }
    
    func setupUI() {
        // Add a label for identification
        let label = UILabel()
        label.text = "Preview Area"
        label.textColor = .white
        view.addSubview(label)
        
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}

extension PreviewViewController: PreviewViewControllerProtocol {
    func setupPlayer(url: URL) {
        previewLayer?.removeFromSuperlayer()
        player = AVPlayer(url: url)
        previewLayer = AVPlayerLayer(player: player)
        previewLayer?.videoGravity = .resizeAspect
        if let previewLayer {
            view.layer.addSublayer(previewLayer)
            
        }
    }
}
