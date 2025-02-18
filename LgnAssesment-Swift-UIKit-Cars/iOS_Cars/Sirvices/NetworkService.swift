//
//  NetworkService.swift
//  iOS
//
//  Created by Oleh Poremskyy on 29.12.2024.
//

import Foundation
import Combine

let kServerCollectionObjectsUrl = "https://"

enum APIError: Error {
    case invalidURL
    case requestFailed(String)
    case decodingFailed
}

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

enum Endpoint {
    case justGet

    
    var path: String {
        switch self {
        case .justGet:
            return "private-fe87c-simpleclassifieds.apiary-mock.com/"
        }
    }

    var httpMethod: HttpMethod {
        switch self {
        case .justGet:
            return .get
        }
    }
}

enum APIEnvironment {
    case dev

    var baseURL: String {
        switch self {
        case .dev:
            return kServerCollectionObjectsUrl
        }
    }
}


class NetworkService: NetworkServiceProtocol {
    private let baseURL: String

    init(environment: APIEnvironment = NetworkService.defaultEnvironment()) {
        self.baseURL = environment.baseURL
    }

    // MARK: - should be extemded on real project
    static func defaultEnvironment() -> APIEnvironment {
        return .dev
    }

    private func defaultHeaders() -> [String: String] {
        var headers: [String: String] = [
            "Platform": "iOS",
            "User-Token": "your_user_token",
            "uid": "user-id"
        ]

        if let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            headers["App-Version"] = appVersion
        }

        return headers
    }

    func request<T: Decodable>(_ endpoint: Endpoint, headers: [String: String]? = nil, parameters: Encodable? = nil) -> AnyPublisher<T, APIError> {
            // FIXME: - parametrs inserted in url string for now - temporarily
            var params = ""
            if let parameters = parameters as? String {
                params = parameters
            }
        
            guard let url = URL(string: baseURL + endpoint.path + params) else {
                return Fail(error: APIError.invalidURL).eraseToAnyPublisher()
            }
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = endpoint.httpMethod.rawValue
            let allHeaders = defaultHeaders().merging(headers ?? [:], uniquingKeysWith: { (_, new) in new })
                for (key, value) in allHeaders {
                    urlRequest.setValue(value, forHTTPHeaderField: key)
            }
            print(urlRequest)
            return URLSession.shared.dataTaskPublisher(for: urlRequest)
                .subscribe(on: DispatchQueue.global(qos: .default))
                .tryMap { (data, response) -> Data in
                    if let httpResponse = response as? HTTPURLResponse,
                       (200..<300).contains(httpResponse.statusCode) {
                        return data
                    } else {
                        let statusCode = (response as? HTTPURLResponse)?.statusCode ?? -1
                        throw APIError.requestFailed("Request failed with status code: \(statusCode)")
                    }
                }
                .decode(type: T.self, decoder: JSONDecoder())
                .mapError { error -> APIError in
                    if error is DecodingError {
                        return APIError.decodingFailed
                    } else if let apiError = error as? APIError {
                        return apiError
                    } else {
                        return APIError.requestFailed("An unknown error occurred.")
                    }
                }
                .eraseToAnyPublisher()
        }
}
