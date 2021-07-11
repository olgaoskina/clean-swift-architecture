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
    
    func fetchComments(_ request: CommentListModels.FetchCommentList.Request) {
        // TODO: fetch comments
        comments = [
            Comment(title: "Comment 1"),
            Comment(title: "Comment 2"),
            Comment(title: "Comment 3")
        ]
        
        let response = CommentListModels.FetchCommentList.Response(comments: comments)
        presenter?.presentComments(response)
    }
}
