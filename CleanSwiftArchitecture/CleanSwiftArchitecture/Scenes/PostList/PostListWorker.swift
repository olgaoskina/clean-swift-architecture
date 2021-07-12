//
//  PostListWorker.swift
//  CleanSwiftArchitecture
//
//  Created by Olga Dudina on 12.07.2021.
//

import Foundation

class PostListWorker {
    private let networkWorker = NetworkWorker()
    private let converter = DTOToDomainConverter()
    
    private let postListUrl = "https://jsonplaceholder.typicode.com/posts"
    
    func fetchPostList(with params: PostListParams,
                       completion: @escaping ((Result<[Post], NetworkError>) -> Void)) {
        guard let url = URL(string: postListUrl) else {
            DispatchQueue.main.async {
                completion(.failure(.unexpected))
            }
            return
        }
        
        networkWorker.sendRequest(to: url) { result in
            switch result {
            case .success(let data):
                guard let postList = self.parse(data: data) else {
                    DispatchQueue.main.async {
                        completion(.failure(.unexpected))
                    }
                    return
                }
                DispatchQueue.main.async {
                    completion(.success(postList))
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    
    private func parse(data: Data) -> [Post]? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        guard let postResults = try? decoder.decode([PostResult].self, from: data) else {
            return nil
        }
        
        let postList = converter.postList(from: postResults)
        return postList
    }
}
