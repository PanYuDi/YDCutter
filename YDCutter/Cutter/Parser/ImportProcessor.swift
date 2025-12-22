//
//  ParserProtocol.swift
//  YDCutter
//
//  Created by 潘语笛 on 2025/12/20.
//

import Foundation
public protocol ImportProcessorProtocol {
    func importAsset(url: URL) -> BaseClip?
}
