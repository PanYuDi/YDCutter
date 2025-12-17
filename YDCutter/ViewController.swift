//
//  ViewController.swift
//  YDCutter
//
//  Created by PanYuDi on 2025/12/15.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    private let previewVC = PreviewViewController()
    private let videoControlVC = VideoControlViewController()
    private let timelineVC = TimelineViewController()
    private let toolbarVC = ToolBarViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }

    private func setupLayout() {
        // Add PreviewViewController
        addChild(previewVC)
        view.addSubview(previewVC.view)
        previewVC.didMove(toParent: self)
        
        // Add VideoControlViewController
        addChild(videoControlVC)
        view.addSubview(videoControlVC.view)
        videoControlVC.didMove(toParent: self)
        
        // Add TimelineViewController
        addChild(timelineVC)
        view.addSubview(timelineVC.view)
        timelineVC.didMove(toParent: self)
        
        // Add ToolBarViewController
        addChild(toolbarVC)
        view.addSubview(toolbarVC.view)
        toolbarVC.didMove(toParent: self)
        
        // Set constraints using SnapKit
        previewVC.view.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.5)
        }
        
        videoControlVC.view.snp.makeConstraints { make in
            make.top.equalTo(previewVC.view.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(50)
        }
        
        timelineVC.view.snp.makeConstraints { make in
            make.top.equalTo(videoControlVC.view.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(toolbarVC.view.snp.top)
        }
        
        toolbarVC.view.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.height.equalTo(60)
        }
    }
}

