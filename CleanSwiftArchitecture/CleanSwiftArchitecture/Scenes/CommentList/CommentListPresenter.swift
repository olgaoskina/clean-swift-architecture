//
//  CommentListPresenter.swift
//  CleanSwiftArchitecture
//
//  Created by Olga Dudina on 09.07.2021.
//

import Foundation

protocol CommentListPresentationLogic {
    func presentComments(_ response: CommentListModels.FetchCommentList.Response)
}

class CommentListPresenter: CommentListPresentationLogic {
    var viewController: CommentListDisplayLogic?
    
    func presentComments(_ response: CommentListModels.FetchCommentList.Response) {
        let comments = process(comments: response.comments)
        
        let viewModel = CommentListModels.FetchCommentList.ViewModel(comments: comments)
        viewController?.displayComments(viewModel)
    }
    
    private func process(comments: [Comment]) -> [Comment] {
        return comments.map { comment in
            Comment(
                postId: comment.postId,
                id: comment.id,
                name: comment.name,
                email: comment.email,
                body: comment.body.capitalized
            )
        }
    }
}
