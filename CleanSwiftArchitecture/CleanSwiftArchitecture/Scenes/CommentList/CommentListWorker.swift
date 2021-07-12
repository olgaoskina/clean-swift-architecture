//
//  CommentListWorker.swift
//  CleanSwiftArchitecture
//
//  Created by Olga Dudina on 12.07.2021.
//

import Foundation

class CommentListWorker {
    private let networkWorker = NetworkWorker()
    private let converter = DTOToDomainConverter()
    
    private let commentListUrlStringFormat = "https://jsonplaceholder.typicode.com/posts/%d/comments"
    
    func fetchCommentList(with params: CommentListParams,
                          completion: @escaping ((Result<[Comment], NetworkError>) -> Void)) {
        let photosUrlString = String(format: commentListUrlStringFormat, params.postId)
        
        guard let url = URL(string: photosUrlString) else {
            DispatchQueue.main.async {
                completion(.failure(.unexpected))
            }
            return
        }

        networkWorker.sendRequest(to: url) { result in
            switch result {
            case .success(let data):
                guard let commentList = self.parse(data: data) else {
                    DispatchQueue.main.async {
                        completion(.failure(.unexpected))
                    }
                    return
                }
                DispatchQueue.main.async {
                    completion(.success(commentList))
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    
    private func parse(data: Data) -> [Comment]? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        guard let commentResults = try? decoder.decode([CommentResult].self, from: data) else {
            return nil
        }
        
        let commentList = converter.commentList(from: commentResults)
        return commentList
    }
}
