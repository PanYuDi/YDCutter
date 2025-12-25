//
//  PreviewViewController.swift
//  YDCutter
//
//  Created by 潘语笛 on 2025/12/17.
//

import UIKit
import SnapKit
import AVFoundation
import Combine

public protocol PreviewViewControllerProtocol {
    func setupPlayer(url: URL)
}

class PreviewViewController: BaseCutViewController<BaseCutViewModel> {
    var player: AVPlayer? = nil
    var previewLayer: AVPlayerLayer? = nil
    var cancellable: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupUI()
        setupObserve()

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
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        previewLayer?.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        
    }
    func setupObserve() {
        self.viewModel.statePublisher?.sink { [weak self] state in
            guard let self else {
                return
            }
            if let url = state.url {
                self.setupPlayer(url: url)
            }
        }.store(in: &cancellable)
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
            previewLayer.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        }
    }
}
