import Foundation
import RequestKit

// MARK: model

@objc open class File: NSObject {
    open var path: String?
    open var mode: String?
    open var type: String?
    open var sha: String?
    open var url: String?
    open var size: Int
    
    public init(_ json: [String: AnyObject]) {
        path = json["path"] as? String
        mode = json["mode"] as? String
        type = json["type"] as? String
        sha = json["sha"] as? String
        url = json["url"] as? String
        size = json["size"] as? Int ?? 0
    }
}
