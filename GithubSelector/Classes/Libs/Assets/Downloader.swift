//
//  Downloader.swift
//  Pods
//
//  Created by Ondrej Rafaj on 22/08/2017.
//
//

import Foundation
import UIKit


enum DownloaderError: Error {
    case downloadFailed
    case invalidImageData
}


class Downloader {
    
    static let shared = Downloader()
    
    fileprivate var fileCache: [String: Data] = [:]
    
    lazy var downloadsInProgress: [IndexPath: Operation] = [:]
    lazy var downloadQueue: OperationQueue = {
        var queue = OperationQueue()
        queue.maxConcurrentOperationCount = 2
        return queue
    }()
    
    
    // MARK: Getting images
    
    func get(url: String, cache: Bool = true, completion: @escaping ((UIImage?, Error?)->())) {
        if let data = fileCache[url] {
            if let image = UIImage(data: data) {
                completion(image, nil)
                return
            }
        }
        
        let operation = DownloaderOperation(urlString: url) { (data) in
            guard let data = data else {
                completion(nil, DownloaderError.downloadFailed)
                return
            }
            
            if cache {
                self.fileCache[url] = data
            }
            
            guard let image = UIImage(data: data) else {
                completion(nil, DownloaderError.downloadFailed)
                return
            }
            
            completion(image, nil)
        }
        downloadQueue.addOperation(operation)
    }
    
}

fileprivate class DownloaderOperation: Operation {
    
    private typealias CompletionClosure = ((Data?)->())
    
    private let url: URL
    
    var downloadingFinished: CompletionClosure
    
    // MARK: Initialization
    
    init(urlString: String, completion: @escaping CompletionClosure) {
        url = URL(string: urlString)!
        downloadingFinished = completion
    }
    
    override func main() {
        if let data = Downloader.shared.fileCache[url.path] {
                downloadingFinished(data)
                return
        }
        
        if isCancelled {
            downloadingFinished(nil)
            return
        }
        
        let data = try? Data.init(contentsOf: url)
        
        downloadingFinished(data)
        
        if isCancelled {
            return
        }
    }
    
}
