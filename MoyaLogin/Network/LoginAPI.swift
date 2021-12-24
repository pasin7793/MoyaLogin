import Moya

enum LoginAPI{
    case requiredLogin(user: SigninRequest)
    case requiredRegister(user: SignupRequest)
}

extension LoginAPI: TargetType{
    var baseURL: URL{
        return URL(string: "http://10.53.68.75:3306/api/v1")!
    }
    var path: String {
        switch self {
        case .requiredLogin:
            return "/login"
        case .requiredRegister:
            return "/register"
        }
    }
    
    var method: Method {
        switch self{
            case .requiredLogin,
                .requiredRegister:
            return .post
        }
    }
    
    var task: Task {
        switch self{
        case .requiredLogin(let user):
            return .requestParameters(parameters: ["email": user.email, "password" : user.password], encoding: JSONEncoding.default)
        case .requiredRegister(let user):
            return .requestParameters(parameters: ["fullName": user.fullName, "email": user.email, "password": user.password], encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}
