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
        let comments = response.comments.map { Comment(
            postId: $0.postId,
            id: $0.id,
            name: $0.name,
            email: $0.email,
            body: $0.body.replacingOccurrences(of: " ", with: "_")
        ) }
        
        let viewModel = CommentListModels.FetchCommentList.ViewModel(comments: comments)
        viewController?.displayComments(viewModel)
    }
}
