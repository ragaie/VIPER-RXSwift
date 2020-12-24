import Foundation
import Moya


let DinDinnProvider = MoyaProvider<DinDinn>()

// MARK: - Provider support

public enum DinDinn {
  case home

}

extension DinDinn: TargetType {
    
  public var baseURL: URL { return URL(string: "https://dindin.getsandbox.com")! }
  public var path: String {
    switch self {
    case .home:
      return "/home"
   
    }
  }
  public var method: Moya.Method {
    return .get
  }
   public var headers: [String: String]? {
         return ["Content-type": "application/json"]
     }

  public var task: Task {
    return Task.requestPlain
  }
 
  public var sampleData: Data {
    switch self {
    case .home:
      return "no data found here".data(using: String.Encoding.utf8)!
   
    }
  }
    
    
    
}

public func url(_ route: TargetType) -> String {
  return route.baseURL.appendingPathComponent(route.path).absoluteString
}
