//
//  ServiceManager.swift
//  POCNetworkManager
//
//  Created by Vidyasagar Kodunuri on 24/06/24.
//

import Foundation

class ServiceManager: NetworkServiceProvider {
    
    typealias URNType = URN
    
    func execute<URNType>(with urnType: URNType) async throws -> URNType.Derived where URNType : URN {
        //GameLogger.print(request.url as Any)
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.waitsForConnectivity = true
        sessionConfig.allowsConstrainedNetworkAccess = true
        sessionConfig.allowsCellularAccess = true
        
        let session = URLSession(configuration: sessionConfig)
        
        do {
            let request = try urnType.getURLRequest()
            let (data, response) = try await session.data(for: request)
             printData(data: data)
            try validateResponse(for: response, data: data)
            let decodedData = try decodeResponse(for: urnType, from: data)
            if request.httpMethod == HTTPMethodType.post.rawValue {
                BusterHelper.shared.updateBuster(type: urnType.pathType.getBusterType)
            }
            return decodedData
        } catch let error as ServiceErrors {
            throw ServiceErrors.message(error.localizedDescription)
        }
    }
    
    private func decodeResponse<URNType>(for urnType: URNType,
                                         from data: Data) throws -> URNType.Derived where URNType : URN {
        let decoder = JSONDecoder()
        do {
            return try decoder.decode(URNType.Derived.self, from: data)
        } catch let error as DecodingError {
            var message: String = String()
            switch error {
            case .typeMismatch(_, let context),
                    .valueNotFound(_, let context):
                message = context.debugDescription
            case .keyNotFound(let codingKey, let context):
                message = context.debugDescription
                    .appending("\(codingKey.description)")
            case .dataCorrupted(let context):
                message = context.debugDescription
            @unknown default:
                message = "Invalid Data Error"
            }
            message = message
                .appending("\n")
                .appending("-")
                .appending(String(describing: URNType.Derived.self))
                .appending("\n")
                .appending("-")
                .appending(String(describing: urnType.pathType.self))
            throw ServiceErrors.message(message)
        }
    }
    
    private func printData(data:Data) {
        if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]{
            print(json)
        } else {
            print(NetworkConstantErrors.badResponse)
        }
    }
}

extension ServiceManager {
    func validateResponse(for response: URLResponse, data: Data) throws {
        guard let response = response as? HTTPURLResponse else {
            throw ServiceErrors.somethingWentWrong
        }
        switch response.statusCode {
        case 200, 201:
            break
        case 202...503:
            let serverResponse = try JSONDecoder().decode(Array<String>?.self, from: data)
#if DEBUG
            throw ServiceErrors.message("\(response.statusCode)\n \(serverResponse ?? [])")
#else
            throw ServiceErrors.message("It Seems something is wrongat our end \n Please try again after sometime")
#endif
        default:
            throw ServiceErrors.somethingWentWrong
        }
    }
}

struct NetworkConstantErrors {
    static let badResponse = "Bad Response"
}
