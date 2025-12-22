//
//  Clips.swift
//  YDCutter
//
//  Created by 潘语笛 on 2025/12/20.
//

import UIKit
import AVFoundation

public class BaseClip: NSObject {
    let id: UUID
    let url: URL               // 视频文件本地路径
    var asset: AVAsset?
    
    init(id: UUID, url: URL) {
        self.id = id
        self.url = url
    }
}
