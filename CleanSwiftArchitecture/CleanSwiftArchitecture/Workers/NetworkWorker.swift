//
//  NetworkWorker.swift
//  CleanSwiftArchitecture
//
//  Created by Olga Dudina on 11.07.2021.
//

import Foundation

enum NetworkError: Error {
    case unexpected
    case internalServerError
    case unknown
    case noData
}

class NetworkWorker {
    func sendRequest(to url: URL,
                     completion: @escaping ((Result<Data, NetworkError>) -> Void)) {
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, urlResponse, error in
            guard error == nil else {
                if let response = urlResponse as? HTTPURLResponse,
                   response.statusCode >= 500 && response.statusCode < 600 {
                    DispatchQueue.main.async {
                        completion(.failure(.internalServerError))
                    }
                } else {
                    DispatchQueue.main.async {
                        completion(.failure(.unknown))
                    }
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(.failure(.noData))
                }
                return
            }
            
            completion(.success(data))
        }.resume()
    }
}
