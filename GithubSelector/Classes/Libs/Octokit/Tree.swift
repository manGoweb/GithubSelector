import Foundation
import RequestKit

// MARK: model

@objc open class Tree: NSObject {
    open var sha: String?
    open var url: String?
    open let files: [File]
    open var truncated: Bool
    
    public init(_ json: [String: AnyObject]) {
        var tree: [File] = []
        if let files = json["tree"] as? [[String: AnyObject]] {
            for file: [String: AnyObject] in files {
                tree.append(File(file))
            }
        }
        files = tree
        sha = json["sha"] as? String
        url = json["url"] as? String
        truncated = json["truncated"] as? Bool ?? false
    }
}

// MARK: request

public extension Octokit {
    
    public func tree(_ session: RequestKitURLSession = URLSession.shared, owner: String, repo: String, sha: String, page: String = "1", perPage: String = "100", completion: @escaping (_ response: Response<Tree>) -> Void) -> URLSessionDataTaskProtocol? {
        let router = TreeRouter.readTree(configuration, owner, repo, sha, page, perPage)
        return router.loadJSON(session, expectedResultType: [String: AnyObject].self) { json, error in
            if let error = error {
                completion(Response.failure(error))
            }
            else {
                if let json = json {
                    let tree = Tree(json)
                    completion(Response.success(tree))
                }
            }
        }
    }
    
}

// MARK: Router

enum TreeRouter: Router {
    case readTree(Configuration, String, String, String, String, String)
    
    var configuration: Configuration {
        switch self {
        case .readTree(let config, _, _, _, _, _): return config
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
        case .readTree(_, _, _, _, let page, let perPage):
            return ["per_page": perPage, "page": page]
        }
    }
    
    var path: String {
        switch self {
        case .readTree(_, let owner, let repo, let sha, _, _):
            return "repos/\(owner)/\(repo)/git/trees/\(sha)"
        }
    }
}
