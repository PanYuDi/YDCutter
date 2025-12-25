//
//  ViewController.swift
//  YDCutter
//
//  Created by PanYuDi on 2025/12/15.
//

import UIKit
import SnapKit
import Photos

class ViewController: UIViewController {

    private let previewVC: PreviewViewController
    private let videoControlVC: VideoControlViewController
    private let timelineVC: TimelineViewController
    private let toolbarVC: ToolBarViewController
    private lazy var importBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Import", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .red
        btn.layer.cornerRadius = 8
        btn.contentEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        btn.addTarget(self, action: #selector(importSegment), for: .touchUpInside)
        return btn
    }()
    private var context: BaseCutContext
    
    required init?(coder: NSCoder) {
        let context = BaseCutContext()
        self.context = context
        previewVC = PreviewViewController(context: context)
        videoControlVC = VideoControlViewController(context: context)
        timelineVC = TimelineViewController(context: context)
        toolbarVC = ToolBarViewController(context: context)
        let initialVCs:[BaseCutViewController] = [previewVC, videoControlVC, timelineVC, toolbarVC]
        for vc in initialVCs {
            vc.context = context
        }
        super.init(coder: coder)
        registerDI()
    }

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
        
        // Add Import Button
        view.addSubview(importBtn)
        importBtn.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-10)
        }
    }
    @objc func importSegment() {
        Task {
            await checkAndRequestPermission()
        }
        
    }
    private func checkAndRequestPermission() async {
        let status = PHPhotoLibrary.authorizationStatus()
        if status != .authorized {
            await PHPhotoLibrary.requestAuthorization(for: .readWrite)
            showVideoPicker()
        } else {
            showVideoPicker()
        }
    }
    @objc
    private func showVideoPicker() {
       // 先判断相册是否可用
       guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
           print("相册不可用")
           return
       }
       
       let picker = UIImagePickerController()
       picker.delegate = self
       // 设置来源为相册
       picker.sourceType = .photoLibrary
       // 过滤仅显示视频（kUTTypeMovie对应视频类型）
       picker.mediaTypes = [UTType.movie.identifier]
       // 弹出选择器
       present(picker, animated: true)
    }
    private func registerDI() {
        
    }
    
}

extension ViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            // 获取视频临时URL（系统会把选中视频复制到App的tmp目录）
        guard let videoURL = info[.mediaURL] as? URL else {
            print("获取视频失败")
            picker.dismiss(animated: true)
            return
        }
        picker.dismiss(animated: true)
        importAssets(url: videoURL)
    }
}

extension ViewController {
    func importAssets(url:URL) {
        var newState = self.context.currentState
        newState.url = url
        self.context.updateState(newState)
    }
}

