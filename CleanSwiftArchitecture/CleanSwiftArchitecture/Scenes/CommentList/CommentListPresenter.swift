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
        let comments = response.comments.map { Comment(title: $0.title.replacingOccurrences(of: " ", with: "_")) }
        
        let viewModel = CommentListModels.FetchCommentList.ViewModel(comments: comments)
        viewController?.displayComments(viewModel)
    }
}
