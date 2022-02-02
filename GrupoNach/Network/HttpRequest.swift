//
//  GrupoNach
//
//  Created by Oscar San juan on 01/02/22.
//

import Foundation

class HttpRequest {
    
    static let shared = HttpRequest()
    
    private init () {}
    
    private struct HandlerStruct<D> {
        let successResponse: (_ success: D) -> Void
        let onFailureResponse: ((_ error: String, _ errorCode: HttpStatusCode) -> Void)?
    }
    
    typealias SuccessHandler<D: Decodable> = (D) -> Void
    typealias ErrorHandler = (_ error: String, _ errorCode: HttpStatusCode) -> Void
    
    private let urlSession: URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.waitsForConnectivity = false
        let uSession = URLSession(configuration: configuration)
        return uSession
    }()
    
    private func getFullPath(actionPath: String) -> URL? {
        return Base.apiURL?.appendingPathComponent(actionPath)
    }
    
}

extension HttpRequest {
    
    func makeRequest<D: Decodable> (onAction: RequestAction, response type: D.Type,
                                    onSuccess: @escaping SuccessHandler<D>,
                                    onFailure: ErrorHandler?) {
        
        let handlerStruct = HandlerStruct<D>(successResponse: onSuccess, onFailureResponse: onFailure)
        guard let request = getURLRequest(onAction) else { return }
        urlSession.dataTask(with: request) { [weak self] (data, response, error) in
            if let error = error {
                onFailure?(error.localizedDescription, .noInternet)
                return
            }
            if let httpResponse = response as? HTTPURLResponse, let data = data {
                let statusCode = HttpStatusCode(rawValue: httpResponse.statusCode)
                debugPrint("StatusCde: \(statusCode)")
                switch statusCode {
                case .success, .created:
                    self?.parseData(type, data, handlerStruct)
                default:
                    self?.parseError(data, handlerStruct.onFailureResponse, errorCode: statusCode)
                }
            } else {
                onFailure?("Error al parsear el data", .parseError)
            }
        }.resume()
    }
    
    private func getURLRequest(_ actionData: RequestAction) -> URLRequest? {
        guard let url = getFullPath(actionPath: actionData.path) else { return nil }
        debugPrint("Making request to \(url)")
        var request =  URLRequest(url: url)
        
      //  if let user: User = KeychainService.shared.getUser(), let token = user.token {
        //    request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        //}
        
        let method = actionData.method
        
        if  method == .POST || method == .PUT || method == .DELETE {
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        }
     
        
        request.httpMethod = actionData.method.rawValue
        request.addValue("no-Cache", forHTTPHeaderField: "Cache-Control")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        let body = actionData.getBodyInData()
        if let data = body {
            NSLog(String(data: data, encoding: .utf8) ?? "")
        }
        request.httpBody = body
        return request
    }
    
    private func parseData<D: Decodable>(_ stringType: D.Type, _ data: Data, _ handlerStruct: HandlerStruct<D> ) {
        do {
            debugPrint("Data: \(String(data: data, encoding: .utf8) ?? "")")
            let json = try JSONDecoder().decode(stringType, from: data)
            handlerStruct.successResponse(json)
        } catch let err {
            handlerStruct.onFailureResponse?("Parsing Error \(err)", .parseError)
        }
    }
    
    private func parseError(_ data: Data,
                            _ onFailureResponse: ((_ error: String, _ errorCode: HttpStatusCode) -> Void )?,
                            errorCode: HttpStatusCode) {
        do {
            debugPrint("Data: \(String(data: data, encoding: .utf8) ?? "")")
            let json = try JSONDecoder().decode(Error.self, from: data)
            onFailureResponse?(json.message ?? "", errorCode)
        } catch let err {
            onFailureResponse?("Parsing Error \(err)", errorCode)
        }
    }
    
}
