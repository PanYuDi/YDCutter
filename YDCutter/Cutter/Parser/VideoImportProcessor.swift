//
//  VideoImportProcessor.swift
//  YDCutter
//
//  Created by 潘语笛 on 2025/12/20.
//

import AVFoundation

class VideoImportProcessor: ImportProcessorProtocol {
    func importAsset(url: URL) -> BaseClip? {
        let asset = AVAsset(url: url)
        guard let track = asset.tracks(withMediaType: .video).first else {
            print("未找到视频轨道")
            return nil
        }
        return nil
    }
}
