//
//  GrupoNach
//
//  Created by Oscar San juan on 01/02/22.
//

import Foundation

class RequestAction {
    
    var path: String
    var method: Method!
    var body: Encodable?
    
    init(endpoint: Endpoint, body: Encodable? = nil) {
        path = endpoint.rawValue
        self.method = endpoint.method
        self.body = body
    }
    
    func getBodyInData() -> Data? {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        if let encodableBody = body {
            return encodableBody.toJSONData()
        }
        
        return nil
    }
}

extension Encodable {
    func toJSONData() -> Data? {
        return try? JSONEncoder().encode(self)
    }
    
    var dictionary: [String: Any] {
        guard let data = try? JSONEncoder().encode(self) else { return [:] }
        
        guard let dataSerialized = try? JSONSerialization.jsonObject(with: data, options: .allowFragments),
            let dictionary =  dataSerialized as? [String: Any] else {
                return [:]
        }
        
        return dictionary
    }
}

enum Method: String {
    case GET
    case POST
    case PUT
    case DELETE
    
    var rawValue: String {
        switch self {
        case .GET: return "GET"
        case .POST: return "POST"
        case .PUT: return "PUT"
        case .DELETE: return "DELETE"
        }
    }
}

//MODIFICAR
enum Endpoint {
    case graphic
 
    
//    case registerDevice
//    case acceptTermsAndConditions
    
    var method: Method {
        switch self {
        case .graphic: return .POST
       
            
//        case .registerDevice: return .POST
//        case .acceptTermsAndConditions: return .POST
        }
    }
    
    var rawValue: String {
        switch self {
        case .graphic: return "/helloWorld"
    
            
//        case .registerDevice: return "employee/users/device"
//        case .acceptTermsAndConditions: return "employee/users/accept"
        }
    }
}

