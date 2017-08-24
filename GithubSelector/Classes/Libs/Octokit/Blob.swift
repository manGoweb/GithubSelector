import Foundation
import RequestKit

// MARK: model

@objc open class Blob: NSObject {
    open var content: String?
    open var encoding: String?
    open var url: String?
    open var sha: String?
    open var size: Int
    
    public init(_ json: [String: AnyObject]) {
        content = json["content"] as? String
        encoding = json["encoding"] as? String
        url = json["url"] as? String
        sha = json["sha"] as? String
        size = json["size"] as? Int ?? 0
    }
}

// MARK: request

public extension Octokit {
    
    public func blob(_ session: RequestKitURLSession = URLSession.shared, owner: String, repo: String, fileSha: String, completion: @escaping (_ response: Response<Blob>) -> Void) -> URLSessionDataTaskProtocol? {
        let router = BlobRouter.readBlob(configuration, owner, repo, fileSha)
        return router.loadJSON(session, expectedResultType: [String: AnyObject].self) { json, error in
            if let error = error {
                completion(Response.failure(error))
            } else {
                if let json = json {
                    let object = Blob(json)
                    completion(Response.success(object))
                }
            }
        }
    }
    
}

// MARK: Router

enum BlobRouter: Router {
    case readBlob(Configuration, String, String, String)
    
    var configuration: Configuration {
        switch self {
        case .readBlob(let config, _, _, _): return config
        }
    }
    
    var method: HTTPMethod {
        return .GET
    }
    
    var encoding: HTTPEncoding {
        return .url
    }
    
    var params: [String: Any] {
        switch self {
        case .readBlob(_, _, _, _):
            return [:]
        }
    }
    
    var path: String {
        switch self {
        case .readBlob(_, let owner, let repo, let sha):
            return "repos/\(owner)/\(repo)/git/blobs/\(sha)"
        }
    }
}
