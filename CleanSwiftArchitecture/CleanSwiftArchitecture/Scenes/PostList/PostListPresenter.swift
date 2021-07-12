//
//  PostListPresenter.swift
//  CleanSwiftArchitecture
//
//  Created by Olga Dudina on 09.07.2021.
//

import Foundation

protocol PostListPresentationLogic {
    func presentPosts(_ response: PostListModels.FetchPostList.Response)
}

class PostListPresenter: PostListPresentationLogic {
    var viewController: PostListDisplayLogic?
    
    func presentPosts(_ response: PostListModels.FetchPostList.Response) {
        let posts = response.posts.map { Post(
            userId: $0.userId,
            id: $0.id,
            title: $0.title.replacingOccurrences(of: " ", with: "-"),
            body: $0.body
        ) }
        
        let viewModel = PostListModels.FetchPostList.ViewModel(posts: posts)
        viewController?.displayPosts(viewModel)
    }
}
