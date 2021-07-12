//
//  CommentListInteractor.swift
//  CleanSwiftArchitecture
//
//  Created by Olga Dudina on 09.07.2021.
//

import Foundation

protocol CommentListBusinessLogic {
    func fetchComments(_ request: CommentListModels.FetchCommentList.Request)
}

protocol CommentListDataStore {
    var post: Post? { get set }
    var comments: [Comment] { get }
}
class CommentListInteractor: CommentListBusinessLogic, CommentListDataStore {
    var post: Post?
    var comments: [Comment] = []
    var presenter: CommentListPresentationLogic?
    
    private let worker = CommentListWorker()
    
    func fetchComments(_ request: CommentListModels.FetchCommentList.Request) {
        guard let post = post else {
            // TODO: handle error
            failure()
            return
        }

        let commentParams = CommentListParams(postId: post.id)
        worker.fetchCommentList(with: commentParams) { result in
            switch result {
            case .success(let comments):
                self.success(comments)
            case .failure(_):
                self.failure()
            }
        }
    }
    
    private func success(_ comments: [Comment]) {
        self.comments = comments
        let response = CommentListModels.FetchCommentList.Response(comments: comments)
        self.presenter?.presentComments(response)
    }
    
    private func failure() {
        // TODO: handle error
        self.comments = []
        let response = CommentListModels.FetchCommentList.Response(comments: [])
        self.presenter?.presentComments(response)
    }
}
